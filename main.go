package main

import (
    "fmt"
    "time"
)

func main() {
    fmt.Println("Started")
    for {
        time.Sleep(time.Minute)
        fmt.Println("still alive...")
    }
}