#!/usr/bin/env python3
import sys, re

def main():
    if len(sys.argv) != 3:
        print("usage: update_variety_sources.py VARIETY_CONF NEW_DIR", file=sys.stderr)
        return 2
    conf_path = sys.argv[1]
    new_dir = sys.argv[2]
    out_lines = []
    in_sources = False
    updated = False
    src_counter = 999

    with open(conf_path, 'r') as f:
        for line in f:
            stripped = line.strip()
            if stripped.startswith('['):
                if in_sources and not updated:
                    out_lines.append(f"src{src_counter} = True|folder|{new_dir}\n")
                    updated = True
                in_sources = (stripped == '[sources]')
                out_lines.append(line)
                continue
            if in_sources:
                m = re.match(r"\s*(src\d+)\s*=\s*(True|False)\|folder\|(.*)", line)
                if m:
                    key = m.group(1)
                    if not updated:
                        out_lines.append(f"{key} = True|folder|{new_dir}\n")
                        updated = True
                    else:
                        out_lines.append(f"{key} = False|folder|{m.group(3).rstrip()}\n")
                    continue
            out_lines.append(line)

    if in_sources and not updated:
        out_lines.append(f"src{src_counter} = True|folder|{new_dir}\n")

    with open(conf_path, 'w') as f:
        f.writelines(out_lines)

if __name__ == '__main__':
    raise SystemExit(main())





