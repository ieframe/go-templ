package main

import (
	"log"
	"net/http"

	"github.com/alexedwards/flow"
	"github.com/ieframe/go-templ/web"
	"github.com/ieframe/go-templ/web/component"
)

func main() {
	/* Flow mux setup */
	mux := flow.New()
	mux.Handle("/static/...", http.FileServerFS(web.Static), http.MethodGet)

	/* Register handler functions */
	mux.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		component.Root("Web", component.Layout()).Render(r.Context(), w)
	}, http.MethodGet)

	/* Start server */
	log.Println("starting server...")
	if err := http.ListenAndServe("127.0.0.1:8080", mux); err != nil {
		log.Fatal(err)
	}
}
