#!/usr/bin/env python3
"""Dynamically update i3wm workspace names based on running applications in each and optionally define an icon to show instead."""

import json
import os.path
import argparse
import re
import i3ipc
import configparser
import traceback

DIR = "/home/user/.config/i3/scripts/wsnaming/"
CONF = DIR + "wsconfig.ini"
WSICONMAP = {
	"window_title=Email.*Outlook.*": "email",
	"window_title=Google Calendar.*": "calendar",
	"window_title=Tasks - Nextcloud.*": "tasks",
	"window_title=.*WhatsApp - Personal.*": "whatsapp",
	"window_title=.*YouTube.*": "youtube",
	"window_class=Alacritty": "terminal",
	"window_class=Arduino IDE": "code",
	"window_class=Code": "vscode",
	"window_class=discord": "video",
	"window_class=Evince": "pdf",
	"window_class=Evolution": "email",
	"window_class=firefox": "browser",
	"window_class=[fF]ont-.*": "fonts",
	"window_class=Inkscape": "draw",
	"window_class=jetbrains-studio": "androidstudio",
	"window_class=libreoffice-calc": "excel",
	"window_class=libreoffice-writer": "word",
	"window_class=MATLAB R202.*": "code",
	"window_class=Microsoft-edge": "browser",
	"window_class=Microsoft Teams - Preview": "teams",
	"window_class=[mM]inecraft.*": "minecraft",
	"window_class=mpv": "video",
	"window_class=Mysql-workbench-bin": "sql",
	"window_class=obsidian": "note", 
	"window_class=Nemo": "files",
	"window_class=Spotify": "music",
	"window_class=TelegramDesktop": "telegram",
	"window_class=[tT]hunderbird": "email",
	"window_class=VirtualBox Manager": "virtualbox",
	"window_class=whatsapp-nativefier-d40211": "whatsapp",
	"window_class=Whatsapp-for-linux": "whatsapp",
	"window_class=zoom": "video"
}

def build_rename(i3, args=None):
	"""Build rename callback function to pass to i3ipc.

	Parameters
	----------
	i3: `i3ipc.i3ipc.Connection`
	app_icons: `dict[str, str]`
		Index of application-name regex (from i3) to icon-name (in font-awesome gallery).

	Returns
	-------
	func
		The rename callback.
	"""

	config = configparser.ConfigParser()
	config.read(CONF)
	app_icons = config['ICONS']
	default_icons = config['DEFAULTS']

	def get_icon_or_name(leaf):
		for key in WSICONMAP.keys():
			identifier = key.split('=')[0]
			name_re = key.split('=')[1]
			name = getattr(leaf, identifier, None)
			if name and re.match(name_re, name):
				try:
					return app_icons[WSICONMAP[key]]
				except:
					return app_icons['window']
		return None

	def rename(i3, e):
		try:
			config = configparser.ConfigParser()
			config.read(CONF)
			ws_icons = config['WSICONS']

			workspaces = i3.get_tree().workspaces()
			# need to use get_workspaces since the i3 con object doesn't have the visible property for some reason
			workdicts = i3.get_workspaces()
			visible = [workdict.name for workdict in workdicts if workdict.visible]
			visworkspaces = []
			focus = ([workdict.name for workdict in workdicts if workdict.focused] or [None])[0]
			focusname = None

			commands = []
			for workspace in workspaces:
				if ws_icons[str(workspace.num)] != 'auto':
					continue
				names = [get_icon_or_name(leaf) for leaf in workspace.leaves()]
				names = [names[0]] if len(names) else [None]
				names = names[0] if names[0] else default_icons['ws%d'%workspace.num]
				# if int(workspace.num) >= 0:
				newname = u"{} {}".format(workspace.num, names)
				# else:
					# newname = names

				if workspace.name in visible:
					visworkspaces.append(newname)
				if workspace.name == focus:
					focusname = newname

				if workspace.name != newname:
					commands.append('rename workspace "{}" to "{}"'.format(
						# escape any double quotes in old or new name.
						workspace.name.replace('"', '\\"'), newname.replace('"', '\\"')))

			if args and args.verbose:
				print(commands)

			# we have to join all the activate workspaces commands into one or the order
			# might get scrambled by multiple i3-msg instances running asyncronously
			# causing the wrong workspace to be activated last, which changes the focus.
			i3.command(u';'.join(commands))

		except Exception as e:
			f = open(DIR + "log", 'w')
			f.write(str(e))
			f.write(traceback.format_exc())
			f.close()

	return rename

def _verbose_startup(i3):
	for w in i3.get_tree().workspaces():
		print('WORKSPACE: "{}"'.format(w.name))
		for i, l in enumerate(w.leaves()):
			print('''===> leaf: {}
-> name: {}
-> window_title: {}
-> window_instance: {}
-> window_class: {}'''.format(i, l.name, l.window_title, l.window_instance, l.window_class))


def main():
	parser = argparse.ArgumentParser(__doc__)
	parser.add_argument("-v", "--verbose", help="verbose startup that will help you to find the right name of the window",
						action="store_true",
						required=False,
						default=False)
	args = parser.parse_args()

	# build i3-connection
	i3 = i3ipc.Connection()
	if args.verbose:
		_verbose_startup(i3)

	rename = build_rename(i3, args)
	for case in ['window::move', 'window::new', 'window::title', 'window::close', 'window::focus']:
		i3.on(case, rename)
	i3.main()

def run():
	i3 = i3ipc.Connection()
	rename = build_rename(i3)
	rename(i3, None)

if __name__ == '__main__':
	main()
