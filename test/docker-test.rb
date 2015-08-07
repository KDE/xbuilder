#!/bin/ruby

buildResult = system("docker build -t pms-test ../image")

if buildResult then
    puts "Awesome"
else
    puts "Awww..."
    exit(1)
end
