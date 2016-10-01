#!/bin/bash
#腾讯云服务器会使用腾讯内部的yum，所以不用更改；其他独立服务器使用阿里的yum源
change_yum() {
     iftencent=`grep 'mirrors.tencentyun.com' /etc/yum.repos.d/CentOS-Base.repo |wc -l`
     releasever=`cat /etc/redhat-release|awk -F'[.]' '{print $1}'|tr -d [:alpha:][:blank:]`
     #echo $releasever $iftencent

     if [ $iftencent -eq 0 ]; then
    echo -n "Change yum "
    mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup

    curl -o /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-$releasever.repo >/dev/null 2>&1|| echo "network error or aliyun's yum is unavailable" 
    success
    echo
    else

       echo "tencentyun pass yum step"
    fi

}
