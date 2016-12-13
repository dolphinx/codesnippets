package main

import (
	"image/jpeg"
	"os"
)

func main() {
	f, err := os.Open("1.jpg")
	if err != nil {
		return
	}
	img, err := jpeg.Decode(f)
	if err != nil {
		return
	}
	bounds := img.Bounds()
	pixel := make([][]byte, bounds.Dy())
	for y := bounds.Min.Y; y < bounds.Max.Y; y++ {
		pixel[y] = make([]byte, bounds.Dx())
		for x := bounds.Min.X; x < bounds.Max.X; x++ {
			uR, uG, uB, _ := img.At(x, y).RGBA()
			r := int(((float32(uR/256)/255-0.5)*10 + 0.5) * 255)
			if r > 255 {
				r = 255
			} else if r < 0 {
				r = 0
			}
			g := int(((float32(uG/256)/255-0.5)*10 + 0.5) * 255)
			if g > 255 {
				g = 255
			} else if g < 0 {
				g = 0
			}
			b := int(((float32(uB/256)/255-0.5)*10 + 0.5) * 255)
			if b > 255 {
				b = 255
			} else if b < 0 {
				b = 0
			}
			p := byte(float32(r)/3 + float32(g)/3 + float32(b)/3)
			pixel[y][x] = p
			if p != 255 {
				pixel[y][x] = 0
			} else {
				pixel[y][x] = 255
			}
		}
	}
}
