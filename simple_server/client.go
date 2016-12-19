package main

import (
    "fmt"
    "net/http"
    "time"
)

func main() {
    t := time.Now()
    for i := 0; i < 100000; i++ {
        read("http://localhost/test")
    }
    fmt.Println(time.Since(t))
    read("http://localhost/")
}

func read(url string) {
    _, err := http.Head(url)
    if err != nil {
        fmt.Println(err)
    }
}