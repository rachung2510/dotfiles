#!/usr/bin/env python3
from i3ipc import Connection
i3 = Connection()
lst = []
for leaf in i3.get_tree().scratchpad().leaves():
	s = f'{leaf.window} {leaf.window_class} {leaf.window_title}'
	lst.append(s)

print("\n".join(lst))
