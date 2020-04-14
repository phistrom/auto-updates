:log info "Checking if firmware needs updating"
:local SPECIALCOMMENT "_________AUTOUPGRADE SCRIPT (delete me if you see me. I prevent the router from entering a boot loop!)"
:local rb [/system routerboard print as-value]
:local current ($rb->"current-firmware")
:local upgrade ($rb->"upgrade-firmware")
:local seenbefore ([:len [/ip firewall raw find comment=$SPECIALCOMMENT]] > 0)

:if ($current != $upgrade) do={
    :if ($seenbefore) do={
        :log error "Unable to upgrade firmware. Manually upgrade the firmware yourself and then delete the disabled RAW firewall rule we created to prevent boot loops."
    } else={
        # this is our way of preventing boot loops. 
        # We check for this rule to see if we have attempted this install before.
        /ip firewall raw add disabled=yes action=passthrough chain=output \
        comment=$SPECIALCOMMENT
        /system routerboard upgrade
        /system reboot
    }
    
} else={
    # clean up our placeholder raw rule if it's still there
    :log info ("Routerboard firmware (" . $current . ") is up-to-date.");
    /ip firewall raw remove [find comment=$SPECIALCOMMENT]
}
