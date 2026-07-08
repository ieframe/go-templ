//go:build !run

package web

import "embed"

//go:embed static/*
var Static embed.FS
