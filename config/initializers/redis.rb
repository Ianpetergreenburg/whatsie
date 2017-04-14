uri = URI.parse("redis://redistogo:0d2e89b44411640b145171920259f26f@barreleye.redistogo.com:10982/" || "redis://localhost:6379/" )
REDIS = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
