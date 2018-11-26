// Copyright 2018 Google Inc. All rights reserved.
// Use of this source code is governed by the Apache 2.0
// license that can be found in the LICENSE file.

// [START gae_go111_app]

// Sample helloworld is an App Engine app.
package main

// [START import]
import (
	"bytes"
	"encoding/json"
	"fmt"
	"io/ioutil"
	"log"
	"net/http"
	"os"
)

// [END import]
// [START main_func]

func main() {
	http.HandleFunc("/", indexHandler)

	// [START setting_port]
	port := os.Getenv("PORT")
	if port == "" {
		port = "8080"
		log.Printf("Defaulting to port %s", port)
	}

	log.Printf("Listening on port %s", port)
	log.Fatal(http.ListenAndServe(fmt.Sprintf(":%s", port), nil))
	// [END setting_port]
}

// [END main_func]

// [START indexHandler]

// indexHandler responds to requests with our greeting.
func indexHandler(w http.ResponseWriter, r *http.Request) {
	if r.URL.Path != "/" {
		http.NotFound(w, r)
		return
	}

	jsonData := map[string]string{"message": "Hello World"}
	jsonValue, _ := json.Marshal(jsonData)

	response, err := http.Post("https://service1-dot-our-places-dev.appspot.com/_ah/api/echo/v1/echo?n=2", "application/json", bytes.NewBuffer(jsonValue))
	
	if err != nil {
		data, _ := ioutil.ReadAll(response.Body)
		fmt.Fprint(w, data)
	} else {
		fmt.Fprintf(w, "Could not get POST response: %v. Data: %v", err, jsonData)
	}
}

// [END indexHandler]
// [END gae_go111_app]
