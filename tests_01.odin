package test

import "core:fmt"
print :: fmt.println

main :: proc() {
    print(length_of_longest_substring_01("abcdefabulous"))

    // needed for `length_of_longest_substring_00()`
    // free_all(context.temp_allocator)
}


// simple, 'first way I thought of' solution
// Average Time in Debug Build:      19026 ns
// Average Time in Optimized Build:   2772 ns
length_of_longest_substring_00 :: proc(s: string) -> int {
    left, right := 0, 1
    count := 0
    max_count := 0
    test_string := ""

    for i in 0 ..< len(s) {
        for j in i+1 ..< len(s) + 1 {
            test_string = s[i:j]
            // print(test_string)
            if count_of_all_characters_is_one(test_string) {
                if len(test_string) > max_count {
                    max_count = len(test_string)
                }
            } else {
                break
            }
        }
    }

    return max_count
}

count_of_all_characters_is_one :: proc(s: string) -> bool {
    c := Counter(s)
    for val in s {
        if c[val] != 1 {
            return false
        }
    }
    return true
}


// better, more efficient solution
// Average Time in Debug Build:      185 ns
// Average Time in Optimized Build:   32 ns
length_of_longest_substring_01 :: proc(s: string) -> int {
    seen := [128]u8{} // ASCII character frequency
    left := 0
    max_len := 0

    for right in 0 ..< len(s) {
        char := s[right]
        seen[char] += 1

        // If duplicate found, shrink window from the left
        // This is a 'while (invalid)...' loop
        for (seen[char]) > 1 {
            seen[s[left]] -= 1
            left += 1
        }

        max_len = max(max_len, right - left + 1)
    }

    return max_len
}

