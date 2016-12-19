package main

import (
	"fmt"
	"net/http"
)

func test(w http.ResponseWriter, r *http.Request) {
	i++
}

func hello(w http.ResponseWriter, r *http.Request) {
	fmt.Println(i)
	w.WriteHeader(http.StatusNotFound)
}

func main() {
	http.HandleFunc("/test", test)
	http.HandleFunc("/", hello)
	http.ListenAndServe(":80", nil)
}

var i int = 0
