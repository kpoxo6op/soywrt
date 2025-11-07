
# OpenWRT Incident Post-Mortem Template

## Incident Summary

Date/Time: Nov 5, 2025 at 3:23 PM NZDT Duration: Unknown (ongoing when switched
back to Eero6)

Affected Services: WiFi connectivity, internet access Severity: High (complete
loss of internet access)

## Timeline

Nov 5, 2025 at 3:23 PM NZDT

Clients disconnected from internet because both SSIDs were gone

Attempted simple reboot: SSIDs became available but not providing internet

Attempted reset (20 sec hold): SSIDs available but still no internet (unclear if
this occurred after reset or simple reboot)

Resolution: Switched back to old Eero6 router

## Impact

Yes

## Root Cause

Root cause unknown - OpenWRT manually configured with UCI over SSH was running
fine previously

## Resolution

Immediate Actions: Switched back to old Eero6 router

## Lessons Learned

What went well: Had old router available for quick fallback

What to improve:

- Enable remote logging
- Enable persistent location for logs
- Configure all with Ansible

Action Items:

- Keep old router around
- Try again with minimal changes over the Weekend for minimal disruption (just
port forwarding to ingress and local DNS, no Tailscale)
