# go-templ

A minimal starting point for server-rendered web apps in Go, using templ for
HTML components and Tailwind CSS for styling. It comes with a live-reload
workflow and builds to a single self-contained binary.

## Requirements

- [Go](https://go.dev) 1.26 or newer, to compile and run the application
- [pnpm](https://pnpm.io), used to run the Tailwind CLI that builds the stylesheet
- Make, to run the build and development tasks in the makefile

The templ CLI is pinned as a Go tool in `go.mod`, so no separate install is needed.

## Using This Template

The Go module is named after this repository, so rename it to your own path
before building on top of it. Update `go.mod`:

```
go mod edit -module github.com/your-name/your-repo
```

Then fix the two imports in `cmd/server/main.go` to match. The app still runs
without this step, but renaming keeps `go install` and imports working correctly.

## Getting Started

Run locally with live reload, then open http://localhost:8080:

```
make live-reload
```

Build a production binary with assets embedded (output: `bin/server`):

```
make build-server
```

## Layout

```
cmd/server/     Entry point and HTTP setup
web/
  component/    templ components and their generated Go files
  style/        Tailwind source stylesheet
  static/       Embedded assets served under /static
```

Static assets are read from disk in development and embedded into the binary in
production. The `run` build tag selects between the two.

## Acknowledgments

- [templ](https://templ.guide): type-safe HTML components for Go
- [Tailwind CSS](https://tailwindcss.com): utility-first CSS framework
- [flow](https://github.com/alexedwards/flow): a small HTTP router
