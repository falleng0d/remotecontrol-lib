

init:
	dart pub global activate protoc_plugin

gen:
	protoc --dart_out="grpc:." .\lib\proto\input.proto

gen-py:
	protoc --python_out="." .\lib\proto\input.proto
