#!/usr/bin/expect
exp_internal 1

# Correct the paths and then run
exec chmod +x ./SDRplay_RSP_API-Linux-3.07.1.run
spawn ./SDRplay_RSP_API-Linux-3.07.1.run # Fixed the path here

expect {
    -regex "RETURN" {
        send "\r"
        exp_continue
    }
    -regex "%" {
        send "\r"
        exp_continue
    }
    -regex "Press y" {
        send "y\r"
    }
    
    eof { 
        send_user "Reached end of file\n"
    }
    timeout { 
        send_user "Timeout occurred\n"
    }
}

expect eof


