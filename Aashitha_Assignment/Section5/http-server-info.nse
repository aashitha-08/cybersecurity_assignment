description = [[
Gets basic HTTP server information
]]

author = "Student"
license = "Same as Nmap"

portrule = function(host, port)
    return port.number == 80 or port.number == 8080
end

action = function(host, port)
    local socket = nmap.new_socket()
    socket:connect(host.ip, port.number)

    socket:send("GET / HTTP/1.0\r\n\r\n")
    local response = socket:receive()

    socket:close()

    if response then
        return response
    end
end