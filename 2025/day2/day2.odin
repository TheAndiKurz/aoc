package day2

import "core:fmt"
import os "core:os/os2"
import "core:strconv"
import "core:strings"

is_invalid_number :: proc(num: int) -> bool {
	num_str := fmt.tprintf("%d", num)

	if len(num_str) % 2 != 0 {
		return false
	}

	half_len := len(num_str) / 2
	for i in 0 ..< half_len {
		if num_str[i] != num_str[half_len + i] {
			return false
		}
	}

	return true
}

p1 :: proc(data: string) -> (result: int) {
	ranges := strings.split(data, ",")

	for range in ranges {
		range_split := strings.split(range, "-")
		start_str, end_str := range_split[0], range_split[1]

		start, _ := strconv.parse_int(start_str)
		end, _ := strconv.parse_int(end_str)

		for i in start ..= end {
			if is_invalid_number(i) {
				result += i
			}
		}
	}

	return
}

is_invalid_number2 :: proc(num: int) -> bool {
	num_str := fmt.tprintf("%d", num)

	for i in 1 ..= len(num_str) / 2 {
		if len(num_str) % i != 0 {
			continue
		}
		invalid := true
		for j in 0 ..< len(num_str) / i {
			if num_str[:i] != num_str[j * i:j * i + i] {
				invalid = false
				break
			}
		}

		if invalid {
			return true
		}
	}

	return false
}

p2 :: proc(data: string) -> (result: int) {
	ranges := strings.split(data, ",")

	for range in ranges {
		range_split := strings.split(range, "-")
		start_str, end_str := range_split[0], range_split[1]

		start, _ := strconv.parse_int(start_str)
		end, _ := strconv.parse_int(end_str)

		for i in start ..= end {
			if is_invalid_number2(i) {
				fmt.println("Invalid id:", i)
				result += i
			}
		}
	}

	return
}

main :: proc() {
	path, pathError := os.get_executable_directory(context.allocator)
	fmt.ensuref(pathError == nil, "Error getting executable file: %v", pathError)

	filePath := fmt.tprintf("%v/example.txt", path)
	fmt.ensuref(os.exists(filePath), "File does not exist: %v", filePath)
	example, fileError := os.read_entire_file_from_path(filePath, context.allocator)
	fmt.ensuref(fileError == nil, "Error reading file: %v", fileError)

	p1ExampleResult := p1(string(example))
	fmt.ensuref(
		p1ExampleResult == 1227775554,
		"Part 1 example result does not match: %v",
		p1ExampleResult,
	)

	p2ExampleResult := p2(string(example))
	fmt.ensuref(
		p2ExampleResult == 4174379265,
		"Part 2 example result does not match: %v",
		p2ExampleResult,
	)

	filePath = fmt.tprintf("%v/data.txt", path)
	fmt.ensuref(os.exists(filePath), "File does not exist: %v", filePath)
	data, dataFileError := os.read_entire_file_from_path(filePath, context.allocator)
	fmt.ensuref(fileError == nil, "Error reading file: %v", fileError)

	p1Result := p1(string(data))
	fmt.printf("Result part 1: %v\n", p1Result)

	p2Result := p2(string(data))
	fmt.printf("Result part 2: %v\n", p2Result)
}
