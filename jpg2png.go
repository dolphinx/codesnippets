package main

import (
	"image/jpeg"
	"image/png"
	"os"
)

func main() {
	if len(os.Args) == 3 {
		f, err := os.Open(os.Args[1])
		if err != nil {
			return
		}
		defer f.Close()
		img, err := jpeg.Decode(f)
		if err != nil {
			return
		}
		o, err := os.Create(os.Args[2])
		if err != nil {
			return
		}
		defer o.Close()
		png.Encode(o, img)
	}
}
