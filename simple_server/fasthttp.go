package main

import (
	"fmt"
	"github.com/valyala/fasthttp"
)

func test(ctx *fasthttp.RequestCtx) {
	i++
}

func main() {
	m := func(ctx *fasthttp.RequestCtx) {
		switch string(ctx.Path()) {
		case "/test":
			test(ctx)
		default:
			fmt.Println(i)
			ctx.Error("not found", fasthttp.StatusNotFound)
		}
	}
	fasthttp.ListenAndServe(":80", m)
}

var i int = 0
