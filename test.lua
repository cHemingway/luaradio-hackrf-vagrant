-- Read from the HackRF at 10MSps and benchmark
local radio = require('radio')
local src = radio.HackRFSource(135e6, 10e6)
local sink = radio.BenchmarkSink()
local top = radio.CompositeBlock()
top:connect(src, sink)
top:run()