use Mix.Config

config :logger,
  utc_log: true,
  truncate: 8192,
  sync_threshold: 40,
  discard_threshold_for_error_logger: 500,
  compile_time_purge_level: :debug,
  backends: [
            {ExSyslog, :exsyslog_error},
            {ExSyslog, :exsyslog_debug},
            {ExSyslog, :exsyslog_json}
            ]

config :logger, :console,
  level: :error,
  format: "$date $time [$level] $levelpad$node $metadata $message\n",
  metadata: [:module, :line, :function]

config :logger, :exsyslog_error,
  level: :error,
  format: "$date $time [$level] $levelpad$node $metadata $message",
  metadata: [:module, :line, :function],
  ident: "MyApplication",
  facility: :local0,
  option: [:pid, :cons]

config :logger, :exsyslog_debug,
  level: :debug,
  format: "$date $time [$level] $message",
  ident: "MyApplication",
  facility: :local1,
  option: [:pid, :perror]

config :logger, :exsyslog_json,
  level: :debug,
  format: "$message",
  formatter: ExSyslog.JsonFormatter,
  metadata: [:module, :line, :function],
  ident: "MyApplication",
  facility: :local1,
  option: :pid
