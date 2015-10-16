#!/bin/ruby

buildResult = system("docker build --no-cache=true -t pms-test ../image")

if buildResult then
    puts "Awesome"
else
    puts "Awww..."
    exit(1)
end
