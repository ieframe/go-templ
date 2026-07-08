# Build config
CGO_ENABLED ?= 0
LDFLAGS     ?= -s -w
CMDS        := $(notdir $(wildcard cmd/*))

# Templ config
PROXY ?= http://localhost:8080

# Make recepies
live-reload:
	@$(MAKE) -j2 tailwind-watch-minify templ-generate-watch

tailwind-watch-minify:
	@pnx @tailwindcss/cli \
      -i web/style/tailwind.css -o web/static/style/tailwind.min.css -wm

tailwind-minify:
	@pnx @tailwindcss/cli \
      -i web/style/tailwind.css -o web/static/style/tailwind.min.css -m

templ-generate-watch:
	@go tool \
      templ generate -watch -proxy "$(PROXY)" -cmd "go run -tags run cmd/server/main.go"

templ-generate:
	@go tool \
      templ generate

$(addprefix build-, $(CMDS)): build-%: | tailwind-minify templ-generate
	@go mod \
      tidy
	@CGO_ENABLED=$(CGO_ENABLED) go build \
      -ldflags "$(LDFLAGS)" -o bin/$* cmd/$*/main.go

$(addprefix run-, $(CMDS)): run-%: | tailwind-minify templ-generate
	@go run \
      -tags run cmd/$*/main.go

.PHONY: %
