volyova_sources = [
  'server.vala',
  'backend.vala',
  'frontend.vala'
]

libfuse26_dep = declare_dependency(dependencies: dependency('fuse'),
                              compile_args: '-DFUSE_USE_VERSION=26')

volyova_deps = [
  dependency('glib-2.0'),
  dependency('gobject-2.0'),
  dependency('gio-2.0'),
  libfuse26_dep
]

executable('volyova', volyova_sources,
  vala_args: '--target-glib=2.58',  
  dependencies: volyova_deps,
  install: true,
)
