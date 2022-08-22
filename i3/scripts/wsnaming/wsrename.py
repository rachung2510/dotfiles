import argparse
import i3ipc
import configparser

def main():
	parser = argparse.ArgumentParser(__doc__)
	parser.add_argument("-n", "--num", type=int)
	parser.add_argument("-i", "--icon", type=str, nargs='?')
	args = parser.parse_args()

	if not args.icon:
		return

	i3 = i3ipc.Connection()
	workspaces = i3.get_workspaces()

	workspace = [w for w in workspaces if w.num == args.num]
	if len(workspace):
		workspace = workspace[0]
	else:
		return

	newname = u"{} {}".format(workspace.num, args.icon)

	commands = []
	commands.append('rename workspace "{}" to "{}"'.format(
                    # escape any double quotes in old or new name.
                    workspace.name.replace('"', '\\"'), newname.replace('"', '\\"')))
	# print(commands)
	i3.command(u';'.join(commands))
	
if __name__ == '__main__':
    main()
