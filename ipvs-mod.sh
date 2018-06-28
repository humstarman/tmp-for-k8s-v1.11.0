#!/bin/bash
cat > ipvs.modules <<"EOF"
#!/bin/bash
ipvs_modules="ip_vs ip_vs_lc ip_vs_wlc ip_vs_rr ip_vs_wrr ip_vs_lblc ip_vs_lblcr ip_vs_dh ip_vs_sh ip_vs_nq ip_vs_sed ip_vs_ftp nf_conntrack_ipv4"
for kernel_module in ${ipvs_modules}; do
  /sbin/modinfo -F filename ${kernel_module}
  [[ "$?" == "0" ]] && /sbin/modprobe ${kernel_module}
done
EOF
chmod +x ipvs.modules && ./ipvs.modules && lsmod | grep ip_vs
