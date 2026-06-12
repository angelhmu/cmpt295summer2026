package main

import "fmt"

func countAll(words []string) map[string]int{
	map := make(map[string]int)
	for _, word := range words {
		count, ok := map[word]
		if ok {
			count++
		} else {
			map[word]++
		}
	}
	return map
}

func main() {
	words = {"cat", "bunny", "dog", "cat", "bird", "dog", "bird", "bird", "cat"}
	fmt.Println(countAll(words))
}