package day1

import "core:fmt"
import os "core:os/os2"
import "core:strconv"
import "core:strings"

p1 :: proc(data: string) -> int {
	counter := 0
	rotation := 50

	lines := strings.split_lines(data)

	for line in lines {
		if len(line) == 0 {
			continue
		}
		if line[0] == 'L' {
			r, _ := strconv.parse_int(line[1:len(line)])
			rotation -= r
			for rotation < 0 {
				rotation += 100
			}
		} else if line[0] == 'R' {
			r, _ := strconv.parse_int(line[1:len(line)])
			rotation += r
			rotation %= 100
		}

		if rotation == 0 {
			counter += 1
		}
	}

	return counter
}

p2 :: proc(data: string) -> int {
	counter := 0
	rotation := 50

	lines := strings.split_lines(data)

	for line in lines {
		if len(line) == 0 {
			continue
		}
		if line[0] == 'L' {
			r, _ := strconv.parse_int(line[1:len(line)], 10)
			for ; r > 0; r -= 1 {
				rotation -= 1
				if rotation < 0 {
					rotation += 100
				}
				if rotation == 0 {
					counter += 1
				}
			}
		} else if line[0] == 'R' {
			r, _ := strconv.parse_int(line[1:len(line)], 10)
			for ; r > 0; r -= 1 {
				rotation += 1
				if rotation >= 100 {
					rotation -= 100
				}
				if rotation == 0 {
					counter += 1
				}
			}
		}
	}

	return counter
}

main :: proc() {
	path, pathError := os.get_executable_directory(context.allocator)
	fmt.ensuref(pathError == nil, "Error getting executable file: %v", pathError)

	filePath := fmt.tprintf("%v/example.txt", path)
	fmt.ensuref(os.exists(filePath), "File does not exist: %v", filePath)
	example, fileError := os.read_entire_file_from_path(filePath, context.allocator)
	fmt.ensuref(fileError == nil, "Error reading file: %v", fileError)

	p1ExampleResult := p1(string(example))
	fmt.ensuref(p1ExampleResult == 3, "Part 1 example result does not match: %v", p1ExampleResult)

	p2ExampleResult := p2(string(example))
	fmt.ensuref(p2ExampleResult == 6, "Part 2 example result does not match: %v", p2ExampleResult)

	filePath = fmt.tprintf("%v/data.txt", path)
	fmt.ensuref(os.exists(filePath), "File does not exist: %v", filePath)
	data, dataFileError := os.read_entire_file_from_path(filePath, context.allocator)
	fmt.ensuref(fileError == nil, "Error reading file: %v", fileError)

	p1Result := p1(string(data))
	fmt.printf("Result part 1: %v\n", p1Result)

	p2Result := p2(string(data))
	fmt.printf("Result part 2: %v\n", p2Result)
}
