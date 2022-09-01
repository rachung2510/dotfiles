#!/usr/bin/env python3
import i3ipc

tree = i3ipc.Connection().get_tree()
focused = tree.find_focused().workspace().num
lstfull = [w.workspace().num for w in tree.find_fullscreen()]
if focused in lstfull:
	print("true")
	exit()
print("false")

