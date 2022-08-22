#!/usr/bin/env python3
"""Dynamically update i3wm workspace names based on running applications in each and optionally define an icon to show instead."""

import json
import os.path
import argparse
import re
import i3ipc
import configparser

DEFAULT_APP_ICON_CONFIG = {
	"alacritty": "",
	"inkscape": "",
	"microsoft-edge": "",
	"obsidian": "", 
	"org.gnome.nautilus": "",
	"telegram": "",
	"thunderbird": "",
	"Whatsapp -*": "",
	"virtualBox manager": "",
	"zoom": ""
}

def build_rename(i3, app_icons, args=None):
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
	def get_icon_or_name(leaf):
		for identifier in ('name', 'window_title', 'window_instance', 'window_class'):
			name = getattr(leaf, identifier, None)
			if name is None:
				continue
			for name_re in app_icons.keys():
				if re.match(name_re, name, re.IGNORECASE):
					return app_icons[name_re]
		return None

	def rename(i3, e, confpath=""):
		workspaces = i3.get_tree().workspaces()
		# need to use get_workspaces since the i3 con object doesn't have the visible property for some reason
		workdicts = i3.get_workspaces()
		visible = [workdict.name for workdict in workdicts if workdict.visible]
		visworkspaces = []
		focus = ([workdict.name for workdict in workdicts if workdict.focused] or [None])[0]
		focusname = None

		commands = []
		config = configparser.ConfigParser()
		config.read(confpath if confpath else args.config)
		for workspace in workspaces:
			# print(workspace.name)
			if config['ICON'][str(workspace.num)] != 'auto':
				continue
			names = [get_icon_or_name(leaf) for leaf in workspace.leaves()]
			names = [names[0]] if len(names) else [None]
			names = names[0] if names[0] else config['DEFAULT']['ws%d'%workspace.num]
			if int(workspace.num) >= 0:
				newname = u"{} {}".format(workspace.num, names)
			else:
				newname = names

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
	parser.add_argument("-c", "--config")
	parser.add_argument("-v", "--verbose", help="verbose startup that will help you to find the right name of the window",
						action="store_true",
						required=False,
						default=False)
	args = parser.parse_args()

	# print('Using default app-icon config', DEFAULT_APP_ICON_CONFIG)
	app_icons = dict(DEFAULT_APP_ICON_CONFIG)

	# build i3-connection
	i3 = i3ipc.Connection()
	if args.verbose:
		_verbose_startup(i3)

	rename = build_rename(i3, app_icons, args)
	for case in ['window::move', 'window::new', 'window::title', 'window::close', 'window::focus']:
		i3.on(case, rename)
	i3.main()

def run(config):
	i3 = i3ipc.Connection()
	app_icons = dict(DEFAULT_APP_ICON_CONFIG)
	rename = build_rename(i3, app_icons)
	rename(i3,None,config)

if __name__ == '__main__':
	main()
