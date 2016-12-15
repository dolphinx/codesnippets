package main

import (
	"fmt"
	"io/ioutil"
	"net/http"
	"time"
)

var c = make(chan int)

func main() {
	go request()
	time.Sleep(10 * time.Millisecond)
	go request()
	<-c
	<-c
	fmt.Println("done")
}

func request() {
	defer func() {
		c <- 1
	}()
	client := &http.Client{
		CheckRedirect: func(req *http.Request, via []*http.Request) error {
			return http.ErrUseLastResponse
		},
	}

	req, err := http.NewRequest("GET", "http://google.com", nil)
	for {
		if err != nil {
			fmt.Println(err)
			return
		}
		req.Header.Set("User-Agent", "Golang_Spider_Bot/3.0")
		var resp *http.Response
		resp, err = client.Do(req)
		if err != nil {
			fmt.Println(err)
			return
		}
		if resp.StatusCode/100 == 3 {
			resp.Body.Close()
			url, err2 := resp.Location()
			if err2 != nil {
				fmt.Println(err2)
				return
			}
			//fmt.Println(url.String())
			req, err = http.NewRequest("GET", url.String(), nil)
			continue
		}
		defer resp.Body.Close()
		//var body []byte
		_, err = ioutil.ReadAll(resp.Body)
		if err == nil {
			//fmt.Println(string(body))
			fmt.Println("one thread")
			return
		}
	}
}
