
#### Linux syscall table


Did look several times for a complete and up to date linux syscall table.

Here is a quick hack, to fetch the call numbers and the arguments from the kernel sources,
	  and generate a html table.


The 'script' (it is functional, that's all) is linked below.

Most syscalls are declared within a single file. Few syscalls might not be predeclared at all,
and / or to be found within other files. Yet I didn't need them, and there are the manpages as well.

So, I leave this the way it is. 

Looking at this - this won't win a prize, but, took me only few minutes to setup.

Did look specifically for the landlock syscalls. Which are now numbered below.


[parse.pl](parse.pl)
<html>
<body>
<h3>Linux syscall table amd64 6.3</h3>
<table>
<tr bgcolor="aliceblue"><td>0</td><td>read</td><td>uint fd</td><td> char  *buf</td><td> size_t count</td></tr>
<tr><td>1</td><td>write</td><td>uint fd</td><td> const char  *buf</td><td>size_t count</td></tr>
<tr bgcolor="aliceblue"><td>2</td><td>open</td><td>const char  *filename</td><td>int flags</td><td> umode_t mode</td></tr>
<tr><td>3</td><td>close</td><td>uint fd</td></tr>
<tr bgcolor="aliceblue"><td>4</td><td>stat</td><td>const char  *filename</td><td>struct stat  *statbuf</td></tr>
<tr><td>5</td><td>fstat</td><td>uint fd</td><td>struct stat  *statbuf</td></tr>
<tr bgcolor="aliceblue"><td>6</td><td>lstat</td><td>const char  *filename</td><td>struct stat  *statbuf</td></tr>
<tr><td>7</td><td>poll</td><td>struct pollfd  *ufds</td><td> uint nfds</td><td>int timeout</td></tr>
<tr bgcolor="aliceblue"><td>8</td><td>lseek</td><td>uint fd</td><td> off_t offset</td><td>uint whence</td></tr>
<tr><td>9</td><td>mmap</td><td>ulong addr</td><td> ulong len</td><td>ulong prot</td><td> ulong flags</td><td>ulong fd</td><td> ulong pgoff</td></tr>
<tr bgcolor="aliceblue"><td>10</td><td>mprotect</td><td>ulong start</td><td> size_t len</td><td>ulong prot</td></tr>
<tr><td>11</td><td>munmap</td><td>ulong addr</td><td> size_t len</td></tr>
<tr bgcolor="aliceblue"><td>12</td><td>brk</td><td>ulong brk</td></tr>
<tr><td>13</td><td>rt_sigaction</td><td>int</td><td>const struct sigaction  *</td><td>struct sigaction  *</td><td>size_t</td></tr>
<tr bgcolor="aliceblue"><td>14</td><td>rt_sigprocmask</td><td>int how</td><td> sigset_t  *set</td><td>sigset_t  *oset</td><td> size_t sigsetsize</td></tr>
<tr><td>15</td><td>rt_sigreturn</td><td>?</td></tr>
<tr bgcolor="aliceblue"><td>16</td><td>ioctl</td><td>uint fd</td><td> uint cmd</td><td>ulong arg</td></tr>
<tr><td>17</td><td>pread64</td><td>uint fd</td><td> char  *buf</td><td>size_t count</td><td> loff_t pos</td></tr>
<tr bgcolor="aliceblue"><td>18</td><td>pwrite64</td><td>uint fd</td><td> const char  *buf</td><td>size_t count</td><td> loff_t pos</td></tr>
<tr><td>19</td><td>readv</td><td>ulong fd</td><td>const struct iovec  *vec</td><td>ulong vlen</td></tr>
<tr bgcolor="aliceblue"><td>20</td><td>writev</td><td>ulong fd</td><td>const struct iovec  *vec</td><td>ulong vlen</td></tr>
<tr><td>21</td><td>access</td><td>const char  *filename</td><td> int mode</td></tr>
<tr bgcolor="aliceblue"><td>22</td><td>pipe</td><td>int  *fildes</td></tr>
<tr><td>23</td><td>select</td><td>int n</td><td> fd_set  *inp</td><td> fd_set  *outp</td><td>fd_set  *exp</td><td> struct timeval  *tvp</td></tr>
<tr bgcolor="aliceblue"><td>24</td><td>sched_yield</td><td>void</td></tr>
<tr><td>25</td><td>mremap</td><td>ulong addr</td><td>ulong old_len</td><td> ulong new_len</td><td>ulong flags</td><td> ulong new_addr</td></tr>
<tr bgcolor="aliceblue"><td>26</td><td>msync</td><td>ulong start</td><td> size_t len</td><td> int flags</td></tr>
<tr><td>27</td><td>mincore</td><td>ulong start</td><td> size_t len</td><td>uchar  * vec</td></tr>
<tr bgcolor="aliceblue"><td>28</td><td>madvise</td><td>ulong start</td><td> size_t len</td><td> int behavior</td></tr>
<tr><td>29</td><td>shmget</td><td>key_t key</td><td> size_t size</td><td> int flag</td></tr>
<tr bgcolor="aliceblue"><td>30</td><td>shmat</td><td>int shmid</td><td> char  *shmaddr</td><td> int shmflg</td></tr>
<tr><td>31</td><td>shmctl</td><td>int shmid</td><td> int cmd</td><td> struct shmid_ds  *buf</td></tr>
<tr bgcolor="aliceblue"><td>32</td><td>dup</td><td>uint fildes</td></tr>
<tr><td>33</td><td>dup2</td><td>uint oldfd</td><td> uint newfd</td></tr>
<tr bgcolor="aliceblue"><td>34</td><td>pause</td><td>void</td></tr>
<tr><td>35</td><td>nanosleep</td><td>struct timespec  *rqtp</td><td>struct timespec  *rmtp</td></tr>
<tr bgcolor="aliceblue"><td>36</td><td>getitimer</td><td>int which</td><td> struct itimerval  *value</td></tr>
<tr><td>37</td><td>alarm</td><td>uint seconds</td></tr>
<tr bgcolor="aliceblue"><td>38</td><td>setitimer</td><td>int which</td><td>struct itimerval  *value</td><td>struct itimerval  *ovalue</td></tr>
<tr><td>39</td><td>getpid</td><td>void</td></tr>
<tr bgcolor="aliceblue"><td>40</td><td>sendfile</td><td>int out_fd</td><td> int in_fd</td><td>off_t  *offset</td><td> size_t count</td></tr>
<tr><td>41</td><td>socket</td><td>int</td><td> int</td><td> int</td></tr>
<tr bgcolor="aliceblue"><td>42</td><td>connect</td><td>int</td><td> struct sockaddr  *</td><td> int</td></tr>
<tr><td>43</td><td>accept</td><td>int</td><td> struct sockaddr  *</td><td> int  *</td></tr>
<tr bgcolor="aliceblue"><td>44</td><td>sendto</td><td>int</td><td> void  *</td><td> size_t</td><td> unsigned</td><td>struct sockaddr  *</td><td> int</td></tr>
<tr><td>45</td><td>recvfrom</td><td>int</td><td> void  *</td><td> size_t</td><td> unsigned</td><td>struct sockaddr  *</td><td> int  *</td></tr>
<tr bgcolor="aliceblue"><td>46</td><td>sendmsg</td><td>int fd</td><td> struct user_msghdr  *msg</td><td> uflags</td></tr>
<tr><td>47</td><td>recvmsg</td><td>int fd</td><td> struct user_msghdr  *msg</td><td> uflags</td></tr>
<tr bgcolor="aliceblue"><td>48</td><td>shutdown</td><td>int</td><td> int</td></tr>
<tr><td>49</td><td>bind</td><td>int</td><td> struct sockaddr  *</td><td> int</td></tr>
<tr bgcolor="aliceblue"><td>50</td><td>listen</td><td>int</td><td> int</td></tr>
<tr><td>51</td><td>getsockname</td><td>int</td><td> struct sockaddr  *</td><td> int  *</td></tr>
<tr bgcolor="aliceblue"><td>52</td><td>getpeername</td><td>int</td><td> struct sockaddr  *</td><td> int  *</td></tr>
<tr><td>53</td><td>socketpair</td><td>int</td><td> int</td><td> int</td><td> int  *</td></tr>
<tr bgcolor="aliceblue"><td>54</td><td>setsockopt</td><td>int fd</td><td> int level</td><td> int optname</td><td>char  *optval</td><td> int optlen</td></tr>
<tr><td>55</td><td>getsockopt</td><td>int fd</td><td> int level</td><td> int optname</td><td>char  *optval</td><td> int  *optlen</td></tr>
<tr bgcolor="aliceblue"><td>56</td><td>clone</td><td>ulong</td><td> ulong</td><td> int  *</td><td>int  *</td><td> ulong</td></tr>
<tr><td>57</td><td>fork</td><td>void</td></tr>
<tr bgcolor="aliceblue"><td>58</td><td>vfork</td><td>void</td></tr>
<tr><td>59</td><td>execve</td><td>const char  *filename</td><td>const char  *const  *argv</td><td>const char  *const  *envp</td></tr>
<tr bgcolor="aliceblue"><td>60</td><td>exit</td><td>int error_code</td></tr>
<tr><td>61</td><td>wait4</td><td>pid_t pid</td><td> int  *stat_addr</td><td>int options</td><td> struct rusage  *ru</td></tr>
<tr bgcolor="aliceblue"><td>62</td><td>kill</td><td>pid_t pid</td><td> int sig</td></tr>
<tr><td>63</td><td>uname</td><td>struct old_utsname  *</td></tr>
<tr bgcolor="aliceblue"><td>64</td><td>semget</td><td>key_t key</td><td> int nsems</td><td> int semflg</td></tr>
<tr><td>65</td><td>semop</td><td>int semid</td><td> struct sembuf  *sops</td><td>unsops</td></tr>
<tr bgcolor="aliceblue"><td>66</td><td>semctl</td><td>int semid</td><td> int semnum</td><td> int cmd</td><td> ulong arg</td></tr>
<tr><td>67</td><td>shmdt</td><td>char  *shmaddr</td></tr>
<tr bgcolor="aliceblue"><td>68</td><td>msgget</td><td>key_t key</td><td> int msgflg</td></tr>
<tr><td>69</td><td>msgsnd</td><td>int msqid</td><td> struct msgbuf  *msgp</td><td>size_t msgsz</td><td> int msgflg</td></tr>
<tr bgcolor="aliceblue"><td>70</td><td>msgrcv</td><td>int msqid</td><td> struct msgbuf  *msgp</td><td>size_t msgsz</td><td> long msgtyp</td><td> int msgflg</td></tr>
<tr><td>71</td><td>msgctl</td><td>int msqid</td><td> int cmd</td><td> struct msqid_ds  *buf</td></tr>
<tr bgcolor="aliceblue"><td>72</td><td>fcntl</td><td>uint fd</td><td> uint cmd</td><td> ulong arg</td></tr>
<tr><td>73</td><td>flock</td><td>uint fd</td><td> uint cmd</td></tr>
<tr bgcolor="aliceblue"><td>74</td><td>fsync</td><td>uint fd</td></tr>
<tr><td>75</td><td>fdatasync</td><td>uint fd</td></tr>
<tr bgcolor="aliceblue"><td>76</td><td>truncate</td><td>const char  *path</td><td> long length</td></tr>
<tr><td>77</td><td>ftruncate</td><td>uint fd</td><td> ulong length</td></tr>
<tr bgcolor="aliceblue"><td>78</td><td>getdents</td><td>uint fd</td><td>struct linux_dirent  *dirent</td><td>uint count</td></tr>
<tr><td>79</td><td>getcwd</td><td>char  *buf</td><td> ulong size</td></tr>
<tr bgcolor="aliceblue"><td>80</td><td>chdir</td><td>const char  *filename</td></tr>
<tr><td>81</td><td>fchdir</td><td>uint fd</td></tr>
<tr bgcolor="aliceblue"><td>82</td><td>rename</td><td>const char  *oldname</td><td>const char  *newname</td></tr>
<tr><td>83</td><td>mkdir</td><td>const char  *pathname</td><td> umode_t mode</td></tr>
<tr bgcolor="aliceblue"><td>84</td><td>rmdir</td><td>const char  *pathname</td></tr>
<tr><td>85</td><td>creat</td><td>const char  *pathname</td><td> umode_t mode</td></tr>
<tr bgcolor="aliceblue"><td>86</td><td>link</td><td>const char  *oldname</td><td>const char  *newname</td></tr>
<tr><td>87</td><td>unlink</td><td>const char  *pathname</td></tr>
<tr bgcolor="aliceblue"><td>88</td><td>symlink</td><td>const char  *old</td><td> const char  *new</td></tr>
<tr><td>89</td><td>readlink</td><td>const char  *path</td><td>char  *buf</td><td> int bufsiz</td></tr>
<tr bgcolor="aliceblue"><td>90</td><td>chmod</td><td>const char  *filename</td><td> umode_t mode</td></tr>
<tr><td>91</td><td>fchmod</td><td>uint fd</td><td> umode_t mode</td></tr>
<tr bgcolor="aliceblue"><td>92</td><td>chown</td><td>const char  *filename</td><td>uid_t user</td><td> gid_t group</td></tr>
<tr><td>93</td><td>fchown</td><td>uint fd</td><td> uid_t user</td><td> gid_t group</td></tr>
<tr bgcolor="aliceblue"><td>94</td><td>lchown</td><td>const char  *filename</td><td>uid_t user</td><td> gid_t group</td></tr>
<tr><td>95</td><td>umask</td><td>int mask</td></tr>
<tr bgcolor="aliceblue"><td>96</td><td>gettimeofday</td><td>struct timeval  *tv</td><td>struct timezone  *tz</td></tr>
<tr><td>97</td><td>getrlimit</td><td>uint resource</td><td>struct rlimit  *rlim</td></tr>
<tr bgcolor="aliceblue"><td>98</td><td>getrusage</td><td>int who</td><td> struct rusage  *ru</td></tr>
<tr><td>99</td><td>sysinfo</td><td>struct sysinfo  *info</td></tr>
<tr bgcolor="aliceblue"><td>100</td><td>times</td><td>struct tms  *tbuf</td></tr>
<tr><td>101</td><td>ptrace</td><td>long request</td><td> long pid</td><td> ulong addr</td><td>ulong data</td></tr>
<tr bgcolor="aliceblue"><td>102</td><td>getuid</td><td>void</td></tr>
<tr><td>103</td><td>syslog</td><td>int type</td><td> char  *buf</td><td> int len</td></tr>
<tr bgcolor="aliceblue"><td>104</td><td>getgid</td><td>void</td></tr>
<tr><td>105</td><td>setuid</td><td>uid_t uid</td></tr>
<tr bgcolor="aliceblue"><td>106</td><td>setgid</td><td>gid_t gid</td></tr>
<tr><td>107</td><td>geteuid</td><td>void</td></tr>
<tr bgcolor="aliceblue"><td>108</td><td>getegid</td><td>void</td></tr>
<tr><td>109</td><td>setpgid</td><td>pid_t pid</td><td> pid_t pgid</td></tr>
<tr bgcolor="aliceblue"><td>110</td><td>getppid</td><td>void</td></tr>
<tr><td>111</td><td>getpgrp</td><td>void</td></tr>
<tr bgcolor="aliceblue"><td>112</td><td>setsid</td><td>void</td></tr>
<tr><td>113</td><td>setreuid</td><td>uid_t ruid</td><td> uid_t euid</td></tr>
<tr bgcolor="aliceblue"><td>114</td><td>setregid</td><td>gid_t rgid</td><td> gid_t egid</td></tr>
<tr><td>115</td><td>getgroups</td><td>int gidsetsize</td><td> gid_t  *grouplist</td></tr>
<tr bgcolor="aliceblue"><td>116</td><td>setgroups</td><td>int gidsetsize</td><td> gid_t  *grouplist</td></tr>
<tr><td>117</td><td>setresuid</td><td>uid_t ruid</td><td> uid_t euid</td><td> uid_t suid</td></tr>
<tr bgcolor="aliceblue"><td>118</td><td>getresuid</td><td>uid_t  *ruid</td><td> uid_t  *euid</td><td> uid_t  *suid</td></tr>
<tr><td>119</td><td>setresgid</td><td>gid_t rgid</td><td> gid_t egid</td><td> gid_t sgid</td></tr>
<tr bgcolor="aliceblue"><td>120</td><td>getresgid</td><td>gid_t  *rgid</td><td> gid_t  *egid</td><td> gid_t  *sgid</td></tr>
<tr><td>121</td><td>getpgid</td><td>pid_t pid</td></tr>
<tr bgcolor="aliceblue"><td>122</td><td>setfsuid</td><td>uid_t uid</td></tr>
<tr><td>123</td><td>setfsgid</td><td>gid_t gid</td></tr>
<tr bgcolor="aliceblue"><td>124</td><td>getsid</td><td>pid_t pid</td></tr>
<tr><td>125</td><td>capget</td><td>cap_user_header_t header</td><td>cap_user_data_t dataptr</td></tr>
<tr bgcolor="aliceblue"><td>126</td><td>capset</td><td>cap_user_header_t header</td><td>const cap_user_data_t data</td></tr>
<tr><td>127</td><td>rt_sigpending</td><td>sigset_t  *set</td><td> size_t sigsetsize</td></tr>
<tr bgcolor="aliceblue"><td>128</td><td>rt_sigtimedwait</td><td>const sigset_t  *uthese</td><td>siginfo_t  *uinfo</td><td>const struct timespec  *uts</td><td>size_t sigsetsize</td></tr>
<tr><td>129</td><td>rt_sigqueueinfo</td><td>pid_t pid</td><td> int sig</td><td> siginfo_t  *uinfo</td></tr>
<tr bgcolor="aliceblue"><td>130</td><td>rt_sigsuspend</td><td>sigset_t  *unewset</td><td> size_t sigsetsize</td></tr>
<tr><td>131</td><td>sigaltstack</td><td>const struct sigaltstack  *uss</td><td>struct sigaltstack  *uoss</td></tr>
<tr bgcolor="aliceblue"><td>132</td><td>utime</td><td>char  *filename</td><td>struct utimbuf  *times</td></tr>
<tr><td>133</td><td>mknod</td><td>const char  *filename</td><td> umode_t mode</td><td>udev</td></tr>
<tr bgcolor="aliceblue"><td>134</td><td>uselib</td><td>const char  *library</td></tr>
<tr><td>135</td><td>personality</td><td>uint personality</td></tr>
<tr bgcolor="aliceblue"><td>136</td><td>ustat</td><td>udev</td><td> struct ustat  *ubuf</td></tr>
<tr><td>137</td><td>statfs</td><td>const char  * path</td><td>struct statfs  *buf</td></tr>
<tr bgcolor="aliceblue"><td>138</td><td>fstatfs</td><td>uint fd</td><td> struct statfs  *buf</td></tr>
<tr><td>139</td><td>sysfs</td><td>int option</td><td>ulong arg1</td><td> ulong arg2</td></tr>
<tr bgcolor="aliceblue"><td>140</td><td>getpriority</td><td>int which</td><td> int who</td></tr>
<tr><td>141</td><td>setpriority</td><td>int which</td><td> int who</td><td> int niceval</td></tr>
<tr bgcolor="aliceblue"><td>142</td><td>sched_setparam</td><td>pid_t pid</td><td>struct sched_param  *param</td></tr>
<tr><td>143</td><td>sched_getparam</td><td>pid_t pid</td><td>struct sched_param  *param</td></tr>
<tr bgcolor="aliceblue"><td>144</td><td>sched_setscheduler</td><td>pid_t pid</td><td> int policy</td><td>struct sched_param  *param</td></tr>
<tr><td>145</td><td>sched_getscheduler</td><td>pid_t pid</td></tr>
<tr bgcolor="aliceblue"><td>146</td><td>sched_get_priority_max</td><td>int policy</td></tr>
<tr><td>147</td><td>sched_get_priority_min</td><td>int policy</td></tr>
<tr bgcolor="aliceblue"><td>148</td><td>sched_rr_get_interval</td><td>pid_t pid</td><td>struct timespec  *interval</td></tr>
<tr><td>149</td><td>mlock</td><td>ulong start</td><td> size_t len</td></tr>
<tr bgcolor="aliceblue"><td>150</td><td>munlock</td><td>ulong start</td><td> size_t len</td></tr>
<tr><td>151</td><td>mlockall</td><td>int flags</td></tr>
<tr bgcolor="aliceblue"><td>152</td><td>munlockall</td><td>void</td></tr>
<tr><td>153</td><td>vhangup</td><td>void</td></tr>
<tr bgcolor="aliceblue"><td>154</td><td>modify_ldt</td><td>?</td></tr>
<tr><td>155</td><td>pivot_root</td><td>const char  *new_root</td><td>const char  *put_old</td></tr>
<tr bgcolor="aliceblue"><td>156</td><td>_sysctl</td><td>?</td></tr>
<tr><td>157</td><td>prctl</td><td>int option</td><td> ulong arg2</td><td> ulong arg3</td><td>ulong arg4</td><td> ulong arg5</td></tr>
<tr bgcolor="aliceblue"><td>158</td><td>arch_prctl</td><td>?</td></tr>
<tr><td>159</td><td>adjtimex</td><td>struct timex  *txc_p</td></tr>
<tr bgcolor="aliceblue"><td>160</td><td>setrlimit</td><td>uint resource</td><td>struct rlimit  *rlim</td></tr>
<tr><td>161</td><td>chroot</td><td>const char  *filename</td></tr>
<tr bgcolor="aliceblue"><td>162</td><td>sync</td><td>void</td></tr>
<tr><td>163</td><td>acct</td><td>const char  *name</td></tr>
<tr bgcolor="aliceblue"><td>164</td><td>settimeofday</td><td>struct timeval  *tv</td><td>struct timezone  *tz</td></tr>
<tr><td>165</td><td>mount</td><td>char  *dev_name</td><td> char  *dir_name</td><td>char  *type</td><td> ulong flags</td><td>void  *data</td></tr>
<tr bgcolor="aliceblue"><td>166</td><td>umount2</td><td>?</td></tr>
<tr><td>167</td><td>swapon</td><td>const char  *specialfile</td><td> int swap_flags</td></tr>
<tr bgcolor="aliceblue"><td>168</td><td>swapoff</td><td>const char  *specialfile</td></tr>
<tr><td>169</td><td>reboot</td><td>int magic1</td><td> int magic2</td><td> uint cmd</td><td>void  *arg</td></tr>
<tr bgcolor="aliceblue"><td>170</td><td>sethostname</td><td>char  *name</td><td> int len</td></tr>
<tr><td>171</td><td>setdomainname</td><td>char  *name</td><td> int len</td></tr>
<tr bgcolor="aliceblue"><td>172</td><td>iopl</td><td>?</td></tr>
<tr><td>173</td><td>ioperm</td><td>ulong from</td><td> ulong num</td><td> int on</td></tr>
<tr bgcolor="aliceblue"><td>174</td><td>create_module</td><td>?</td></tr>
<tr><td>175</td><td>init_module</td><td>void  *umod</td><td> ulong len</td><td>const char  *uargs</td></tr>
<tr bgcolor="aliceblue"><td>176</td><td>delete_module</td><td>const char  *name_user</td><td>uint flags</td></tr>
<tr><td>177</td><td>get_kernel_syms</td><td>?</td></tr>
<tr bgcolor="aliceblue"><td>178</td><td>query_module</td><td>?</td></tr>
<tr><td>179</td><td>quotactl</td><td>uint cmd</td><td> const char  *special</td><td>qid_t id</td><td> void  *addr</td></tr>
<tr bgcolor="aliceblue"><td>180</td><td>nfsservctl</td><td>?</td></tr>
<tr><td>181</td><td>getpmsg</td><td>?</td></tr>
<tr bgcolor="aliceblue"><td>182</td><td>putpmsg</td><td>?</td></tr>
<tr><td>183</td><td>afs_syscall</td><td>?</td></tr>
<tr bgcolor="aliceblue"><td>184</td><td>tuxcall</td><td>?</td></tr>
<tr><td>185</td><td>security</td><td>?</td></tr>
<tr bgcolor="aliceblue"><td>186</td><td>gettid</td><td>void</td></tr>
<tr><td>187</td><td>readahead</td><td>int fd</td><td> loff_t offset</td><td> size_t count</td></tr>
<tr bgcolor="aliceblue"><td>188</td><td>setxattr</td><td>const char  *path</td><td> const char  *name</td><td>const void  *value</td><td> size_t size</td><td> int flags</td></tr>
<tr><td>189</td><td>lsetxattr</td><td>const char  *path</td><td> const char  *name</td><td>const void  *value</td><td> size_t size</td><td> int flags</td></tr>
<tr bgcolor="aliceblue"><td>190</td><td>fsetxattr</td><td>int fd</td><td> const char  *name</td><td>const void  *value</td><td> size_t size</td><td> int flags</td></tr>
<tr><td>191</td><td>getxattr</td><td>const char  *path</td><td> const char  *name</td><td>void  *value</td><td> size_t size</td></tr>
<tr bgcolor="aliceblue"><td>192</td><td>lgetxattr</td><td>const char  *path</td><td> const char  *name</td><td>void  *value</td><td> size_t size</td></tr>
<tr><td>193</td><td>fgetxattr</td><td>int fd</td><td> const char  *name</td><td>void  *value</td><td> size_t size</td></tr>
<tr bgcolor="aliceblue"><td>194</td><td>listxattr</td><td>const char  *path</td><td> char  *list</td><td>size_t size</td></tr>
<tr><td>195</td><td>llistxattr</td><td>const char  *path</td><td> char  *list</td><td>size_t size</td></tr>
<tr bgcolor="aliceblue"><td>196</td><td>flistxattr</td><td>int fd</td><td> char  *list</td><td> size_t size</td></tr>
<tr><td>197</td><td>removexattr</td><td>const char  *path</td><td>const char  *name</td></tr>
<tr bgcolor="aliceblue"><td>198</td><td>lremovexattr</td><td>const char  *path</td><td>const char  *name</td></tr>
<tr><td>199</td><td>fremovexattr</td><td>int fd</td><td> const char  *name</td></tr>
<tr bgcolor="aliceblue"><td>200</td><td>tkill</td><td>pid_t pid</td><td> int sig</td></tr>
<tr><td>201</td><td>time</td><td>time_t  *tloc</td></tr>
<tr bgcolor="aliceblue"><td>202</td><td>futex</td><td>u32  *uaddr</td><td> int op</td><td> u32 val</td><td>const struct timespec  *utime</td><td>u32  *uaddr2</td><td> u32 val3</td></tr>
<tr><td>203</td><td>sched_setaffinity</td><td>pid_t pid</td><td> uint len</td><td>ulong  *user_mask_ptr</td></tr>
<tr bgcolor="aliceblue"><td>204</td><td>sched_getaffinity</td><td>pid_t pid</td><td> uint len</td><td>ulong  *user_mask_ptr</td></tr>
<tr><td>205</td><td>set_thread_area</td><td>?</td></tr>
<tr bgcolor="aliceblue"><td>206</td><td>io_setup</td><td>unr_reqs</td><td> aio_context_t  *ctx</td></tr>
<tr><td>207</td><td>io_destroy</td><td>aio_context_t ctx</td></tr>
<tr bgcolor="aliceblue"><td>208</td><td>io_getevents</td><td>aio_context_t ctx_id</td><td>long min_nr</td><td>long nr</td><td>struct io_event  *events</td><td>struct timespec  *timeout</td></tr>
<tr><td>209</td><td>io_submit</td><td>aio_context_t</td><td> long</td><td>struct iocb  *  *</td></tr>
<tr bgcolor="aliceblue"><td>210</td><td>io_cancel</td><td>aio_context_t ctx_id</td><td> struct iocb  *iocb</td><td>struct io_event  *result</td></tr>
<tr><td>211</td><td>get_thread_area</td><td>?</td></tr>
<tr bgcolor="aliceblue"><td>212</td><td>lookup_dcookie</td><td>u64 cookie64</td><td> char  *buf</td><td> size_t len</td></tr>
<tr><td>213</td><td>epoll_create</td><td>int size</td></tr>
<tr bgcolor="aliceblue"><td>214</td><td>epoll_ctl_old</td><td>?</td></tr>
<tr><td>215</td><td>epoll_wait_old</td><td>?</td></tr>
<tr bgcolor="aliceblue"><td>216</td><td>remap_file_pages</td><td>ulong start</td><td> ulong size</td><td>ulong prot</td><td> ulong pgoff</td><td>ulong flags</td></tr>
<tr><td>217</td><td>getdents64</td><td>uint fd</td><td>struct linux_dirent64  *dirent</td><td>uint count</td></tr>
<tr bgcolor="aliceblue"><td>218</td><td>set_tid_address</td><td>int  *tidptr</td></tr>
<tr><td>219</td><td>restart_syscall</td><td>void</td></tr>
<tr bgcolor="aliceblue"><td>220</td><td>semtimedop</td><td>int semid</td><td> struct sembuf  *sops</td><td>unsops</td><td>const struct timespec  *timeout</td></tr>
<tr><td>221</td><td>fadvise64</td><td>int fd</td><td> loff_t offset</td><td> size_t len</td><td> int advice</td></tr>
<tr bgcolor="aliceblue"><td>222</td><td>timer_create</td><td>clockid_t which_clock</td><td>struct sigevent  *timer_event_spec</td><td>timer_t  * created_timer_id</td></tr>
<tr><td>223</td><td>timer_settime</td><td>timer_t timer_id</td><td> int flags</td><td>const struct itimerspec  *new_setting</td><td>struct itimerspec  *old_setting</td></tr>
<tr bgcolor="aliceblue"><td>224</td><td>timer_gettime</td><td>timer_t timer_id</td><td>struct itimerspec  *setting</td></tr>
<tr><td>225</td><td>timer_getoverrun</td><td>timer_t timer_id</td></tr>
<tr bgcolor="aliceblue"><td>226</td><td>timer_delete</td><td>timer_t timer_id</td></tr>
<tr><td>227</td><td>clock_settime</td><td>clockid_t which_clock</td><td>const struct timespec  *tp</td></tr>
<tr bgcolor="aliceblue"><td>228</td><td>clock_gettime</td><td>clockid_t which_clock</td><td>struct timespec  *tp</td></tr>
<tr><td>229</td><td>clock_getres</td><td>clockid_t which_clock</td><td>struct timespec  *tp</td></tr>
<tr bgcolor="aliceblue"><td>230</td><td>clock_nanosleep</td><td>clockid_t which_clock</td><td> int flags</td><td>const struct timespec  *rqtp</td><td>struct timespec  *rmtp</td></tr>
<tr><td>231</td><td>exit_group</td><td>int error_code</td></tr>
<tr bgcolor="aliceblue"><td>232</td><td>epoll_wait</td><td>int epfd</td><td> struct epoll_event  *events</td><td>int maxevents</td><td> int timeout</td></tr>
<tr><td>233</td><td>epoll_ctl</td><td>int epfd</td><td> int op</td><td> int fd</td><td>struct epoll_event  *event</td></tr>
<tr bgcolor="aliceblue"><td>234</td><td>tgkill</td><td>pid_t tgid</td><td> pid_t pid</td><td> int sig</td></tr>
<tr><td>235</td><td>utimes</td><td>char  *filename</td><td>struct timeval  *utimes</td></tr>
<tr bgcolor="aliceblue"><td>236</td><td>vserver</td><td>?</td></tr>
<tr><td>237</td><td>mbind</td><td>ulong start</td><td> ulong len</td><td>ulong mode</td><td>const ulong  *nmask</td><td>ulong maxnode</td><td>uflags</td></tr>
<tr bgcolor="aliceblue"><td>238</td><td>set_mempolicy</td><td>int mode</td><td> const ulong  *nmask</td><td>ulong maxnode</td></tr>
<tr><td>239</td><td>get_mempolicy</td><td>int  *policy</td><td>ulong  *nmask</td><td>ulong maxnode</td><td>ulong addr</td><td> ulong flags</td></tr>
<tr bgcolor="aliceblue"><td>240</td><td>mq_open</td><td>const char  *name</td><td> int oflag</td><td> umode_t mode</td><td> struct mq_attr  *attr</td></tr>
<tr><td>241</td><td>mq_unlink</td><td>const char  *name</td></tr>
<tr bgcolor="aliceblue"><td>242</td><td>mq_timedsend</td><td>mqd_t mqdes</td><td> const char  *msg_ptr</td><td> size_t msg_len</td><td> uint msg_prio</td><td> const struct timespec  *abs_timeout</td></tr>
<tr><td>243</td><td>mq_timedreceive</td><td>mqd_t mqdes</td><td> char  *msg_ptr</td><td> size_t msg_len</td><td> uint  *msg_prio</td><td> const struct timespec  *abs_timeout</td></tr>
<tr bgcolor="aliceblue"><td>244</td><td>mq_notify</td><td>mqd_t mqdes</td><td> const struct sigevent  *notification</td></tr>
<tr><td>245</td><td>mq_getsetattr</td><td>mqd_t mqdes</td><td> const struct mq_attr  *mqstat</td><td> struct mq_attr  *omqstat</td></tr>
<tr bgcolor="aliceblue"><td>246</td><td>kexec_load</td><td>ulong entry</td><td> ulong nr_segments</td><td>struct kexec_segment  *segments</td><td>ulong flags</td></tr>
<tr><td>247</td><td>waitid</td><td>int which</td><td> pid_t pid</td><td>struct siginfo  *infop</td><td>int options</td><td> struct rusage  *ru</td></tr>
<tr bgcolor="aliceblue"><td>248</td><td>add_key</td><td>const char  *_type</td><td>const char  *_description</td><td>const void  *_payload</td><td>size_t plen</td><td>key_serial_t destringid</td></tr>
<tr><td>249</td><td>request_key</td><td>const char  *_type</td><td>const char  *_description</td><td>const char  *_callout_info</td><td>key_serial_t destringid</td></tr>
<tr bgcolor="aliceblue"><td>250</td><td>keyctl</td><td>int cmd</td><td> ulong arg2</td><td> ulong arg3</td><td>ulong arg4</td><td> ulong arg5</td></tr>
<tr><td>251</td><td>ioprio_set</td><td>int which</td><td> int who</td><td> int ioprio</td></tr>
<tr bgcolor="aliceblue"><td>252</td><td>ioprio_get</td><td>int which</td><td> int who</td></tr>
<tr><td>253</td><td>inotify_init</td><td>void</td></tr>
<tr bgcolor="aliceblue"><td>254</td><td>inotify_add_watch</td><td>int fd</td><td> const char  *path</td><td>u32 mask</td></tr>
<tr><td>255</td><td>inotify_rm_watch</td><td>int fd</td><td> __s32 wd</td></tr>
<tr bgcolor="aliceblue"><td>256</td><td>migrate_pages</td><td>pid_t pid</td><td> ulong maxnode</td><td>const ulong  *from</td><td>const ulong  *to</td></tr>
<tr><td>257</td><td>openat</td><td>int dfd</td><td> const char  *filename</td><td> int flags</td><td>umode_t mode</td></tr>
<tr bgcolor="aliceblue"><td>258</td><td>mkdirat</td><td>int dfd</td><td> const char  * pathname</td><td> umode_t mode</td></tr>
<tr><td>259</td><td>mknodat</td><td>int dfd</td><td> const char  * filename</td><td> umode_t mode</td><td>udev</td></tr>
<tr bgcolor="aliceblue"><td>260</td><td>fchownat</td><td>int dfd</td><td> const char  *filename</td><td> uid_t user</td><td>gid_t group</td><td> int flag</td></tr>
<tr><td>261</td><td>futimesat</td><td>int dfd</td><td> const char  *filename</td><td>struct timeval  *utimes</td></tr>
<tr bgcolor="aliceblue"><td>262</td><td>newfstatat</td><td>int dfd</td><td> const char  *filename</td><td>struct stat  *statbuf</td><td> int flag</td></tr>
<tr><td>262</td><td>fstatat</td><td>int dfd</td><td> const char  *filename</td><td>struct stat  *statbuf</td><td> int flag</td></tr>
<tr bgcolor="aliceblue"><td>263</td><td>unlinkat</td><td>int dfd</td><td> const char  * pathname</td><td> int flag</td></tr>
<tr><td>264</td><td>renameat</td><td>int olddfd</td><td> const char  * oldname</td><td>int newdfd</td><td> const char  * newname</td></tr>
<tr bgcolor="aliceblue"><td>265</td><td>linkat</td><td>int olddfd</td><td> const char  *oldname</td><td>int newdfd</td><td> const char  *newname</td><td> int flags</td></tr>
<tr><td>266</td><td>symlinkat</td><td>const char  * oldname</td><td>int newdfd</td><td> const char  * newname</td></tr>
<tr bgcolor="aliceblue"><td>267</td><td>readlinkat</td><td>int dfd</td><td> const char  *path</td><td> char  *buf</td><td>int bufsiz</td></tr>
<tr><td>268</td><td>fchmodat</td><td>int dfd</td><td> const char  * filename</td><td>umode_t mode</td></tr>
<tr bgcolor="aliceblue"><td>269</td><td>faccessat</td><td>int dfd</td><td> const char  *filename</td><td> int mode</td></tr>
<tr><td>270</td><td>pselect6</td><td>int</td><td> fd_set  *</td><td> fd_set  *</td><td>fd_set  *</td><td> struct timespec  *</td><td>void  *</td></tr>
<tr bgcolor="aliceblue"><td>271</td><td>ppoll</td><td>struct pollfd  *</td><td> uint</td><td>struct timespec  *</td><td> const sigset_t  *</td><td>size_t</td></tr>
<tr><td>272</td><td>unshare</td><td>ulong unshare_flags</td></tr>
<tr bgcolor="aliceblue"><td>273</td><td>set_robust_list</td><td>struct robust_list_head  *head</td><td>size_t len</td></tr>
<tr><td>274</td><td>get_robust_list</td><td>int pid</td><td>struct robust_list_head  *  *head_ptr</td><td>size_t  *len_ptr</td></tr>
<tr bgcolor="aliceblue"><td>275</td><td>splice</td><td>int fd_in</td><td> loff_t  *off_in</td><td>int fd_out</td><td> loff_t  *off_out</td><td>size_t len</td><td> uint flags</td></tr>
<tr><td>276</td><td>tee</td><td>int fdin</td><td> int fdout</td><td> size_t len</td><td> uint flags</td></tr>
<tr bgcolor="aliceblue"><td>277</td><td>sync_file_range</td><td>int fd</td><td> loff_t offset</td><td> loff_t nbytes</td><td>uint flags</td></tr>
<tr><td>278</td><td>vmsplice</td><td>int fd</td><td> const struct iovec  *iov</td><td>ulong nr_segs</td><td> uint flags</td></tr>
<tr bgcolor="aliceblue"><td>279</td><td>move_pages</td><td>pid_t pid</td><td> ulong nr_pages</td><td>const void  *  *pages</td><td>const int  *nodes</td><td>int  *status</td><td>int flags</td></tr>
<tr><td>280</td><td>utimensat</td><td>int dfd</td><td> const char  *filename</td><td>struct timespec  *utimes</td><td>int flags</td></tr>
<tr bgcolor="aliceblue"><td>281</td><td>epoll_pwait</td><td>int epfd</td><td> struct epoll_event  *events</td><td>int maxevents</td><td> int timeout</td><td>const sigset_t  *sigmask</td><td>size_t sigsetsize</td></tr>
<tr><td>282</td><td>signalfd</td><td>int ufd</td><td> sigset_t  *user_mask</td><td> size_t sizemask</td></tr>
<tr bgcolor="aliceblue"><td>283</td><td>timerfd_create</td><td>int clockid</td><td> int flags</td></tr>
<tr><td>284</td><td>eventfd</td><td>uint count</td></tr>
<tr bgcolor="aliceblue"><td>285</td><td>fallocate</td><td>int fd</td><td> int mode</td><td> loff_t offset</td><td> loff_t len</td></tr>
<tr><td>286</td><td>timerfd_settime</td><td>int ufd</td><td> int flags</td><td>const struct itimerspec  *utmr</td><td>struct itimerspec  *otmr</td></tr>
<tr bgcolor="aliceblue"><td>287</td><td>timerfd_gettime</td><td>int ufd</td><td> struct itimerspec  *otmr</td></tr>
<tr><td>288</td><td>accept4</td><td>int</td><td> struct sockaddr  *</td><td> int  *</td><td> int</td></tr>
<tr bgcolor="aliceblue"><td>289</td><td>signalfd4</td><td>int ufd</td><td> sigset_t  *user_mask</td><td> size_t sizemask</td><td> int flags</td></tr>
<tr><td>290</td><td>eventfd2</td><td>uint count</td><td> int flags</td></tr>
<tr bgcolor="aliceblue"><td>291</td><td>epoll_create1</td><td>int flags</td></tr>
<tr><td>292</td><td>dup3</td><td>uint oldfd</td><td> uint newfd</td><td> int flags</td></tr>
<tr bgcolor="aliceblue"><td>293</td><td>pipe2</td><td>int  *fildes</td><td> int flags</td></tr>
<tr><td>294</td><td>inotify_init1</td><td>int flags</td></tr>
<tr bgcolor="aliceblue"><td>295</td><td>preadv</td><td>ulong fd</td><td> const struct iovec  *vec</td><td>ulong vlen</td><td> ulong pos_l</td><td> ulong pos_h</td></tr>
<tr><td>296</td><td>pwritev</td><td>ulong fd</td><td> const struct iovec  *vec</td><td>ulong vlen</td><td> ulong pos_l</td><td> ulong pos_h</td></tr>
<tr bgcolor="aliceblue"><td>297</td><td>rt_tgsigqueueinfo</td><td>pid_t tgid</td><td> pid_t  pid</td><td> int sig</td><td>siginfo_t  *uinfo</td></tr>
<tr><td>298</td><td>perf_event_open</td><td>struct perf_event_attr  *attr_uptr</td><td>pid_t pid</td><td> int cpu</td><td> int group_fd</td><td> ulong flags</td></tr>
<tr bgcolor="aliceblue"><td>299</td><td>recvmmsg</td><td>int fd</td><td> struct mmsghdr  *msg</td><td>uint vlen</td><td> uflags</td><td>struct timespec  *timeout</td></tr>
<tr><td>300</td><td>fanotify_init</td><td>uint flags</td><td> uint event_f_flags</td></tr>
<tr bgcolor="aliceblue"><td>301</td><td>fanotify_mark</td><td>int fanotify_fd</td><td> uint flags</td><td>u64 mask</td><td> int fd</td><td>const char   *pathname</td></tr>
<tr><td>302</td><td>prlimit64</td><td>pid_t pid</td><td> uint resource</td><td>const struct rlimit64  *new_rlim</td><td>struct rlimit64  *old_rlim</td></tr>
<tr bgcolor="aliceblue"><td>303</td><td>name_to_handle_at</td><td>int dfd</td><td> const char  *name</td><td>struct file_handle  *handle</td><td>int  *mnt_id</td><td> int flag</td></tr>
<tr><td>304</td><td>open_by_handle_at</td><td>int mountdirfd</td><td>struct file_handle  *handle</td><td>int flags</td></tr>
<tr bgcolor="aliceblue"><td>305</td><td>clock_adjtime</td><td>clockid_t which_clock</td><td>struct timex  *tx</td></tr>
<tr><td>306</td><td>syncfs</td><td>int fd</td></tr>
<tr bgcolor="aliceblue"><td>307</td><td>sendmmsg</td><td>int fd</td><td> struct mmsghdr  *msg</td><td>uint vlen</td><td> uflags</td></tr>
<tr><td>308</td><td>setns</td><td>int fd</td><td> int nstype</td></tr>
<tr bgcolor="aliceblue"><td>309</td><td>getcpu</td><td>u *cpu</td><td> u *node</td><td> struct getcpu_cache  *cache</td></tr>
<tr><td>310</td><td>process_vm_readv</td><td>pid_t pid</td><td>const struct iovec  *lvec</td><td>ulong liovcnt</td><td>const struct iovec  *rvec</td><td>ulong riovcnt</td><td>ulong flags</td></tr>
<tr bgcolor="aliceblue"><td>311</td><td>process_vm_writev</td><td>pid_t pid</td><td>const struct iovec  *lvec</td><td>ulong liovcnt</td><td>const struct iovec  *rvec</td><td>ulong riovcnt</td><td>ulong flags</td></tr>
<tr><td>312</td><td>kcmp</td><td>pid_t pid1</td><td> pid_t pid2</td><td> int type</td><td>ulong idx1</td><td> ulong idx2</td></tr>
<tr bgcolor="aliceblue"><td>313</td><td>finit_module</td><td>int fd</td><td> const char  *uargs</td><td> int flags</td></tr>
<tr><td>314</td><td>sched_setattr</td><td>pid_t pid</td><td>struct sched_attr  *attr</td><td>uint flags</td></tr>
<tr bgcolor="aliceblue"><td>315</td><td>sched_getattr</td><td>pid_t pid</td><td>struct sched_attr  *attr</td><td>uint size</td><td>uint flags</td></tr>
<tr><td>316</td><td>renameat2</td><td>int olddfd</td><td> const char  *oldname</td><td>int newdfd</td><td> const char  *newname</td><td>uint flags</td></tr>
<tr bgcolor="aliceblue"><td>317</td><td>seccomp</td><td>uint op</td><td> uint flags</td><td>void  *uargs</td></tr>
<tr><td>318</td><td>getrandom</td><td>char  *buf</td><td> size_t count</td><td>uint flags</td></tr>
<tr bgcolor="aliceblue"><td>319</td><td>memfd_create</td><td>const char  *uname_ptr</td><td> uint flags</td></tr>
<tr><td>320</td><td>kexec_file_load</td><td>int kernel_fd</td><td> int initrd_fd</td><td>ulong cmdline_len</td><td>const char  *cmdline_ptr</td><td>ulong flags</td></tr>
<tr bgcolor="aliceblue"><td>321</td><td>bpf</td><td>int cmd</td><td> union bpf_attr *attr</td><td> uint size</td></tr>
<tr><td>322</td><td>execveat</td><td>int dfd</td><td> const char  *filename</td><td>const char  *const  *argv</td><td>const char  *const  *envp</td><td> int flags</td></tr>
<tr bgcolor="aliceblue"><td>323</td><td>userfaultfd</td><td>int flags</td></tr>
<tr><td>324</td><td>membarrier</td><td>int cmd</td><td> uint flags</td><td> int cpu_id</td></tr>
<tr bgcolor="aliceblue"><td>325</td><td>mlock2</td><td>ulong start</td><td> size_t len</td><td> int flags</td></tr>
<tr><td>326</td><td>copy_file_range</td><td>int fd_in</td><td> loff_t  *off_in</td><td>int fd_out</td><td> loff_t  *off_out</td><td>size_t len</td><td> uint flags</td></tr>
<tr bgcolor="aliceblue"><td>327</td><td>preadv2</td><td>ulong fd</td><td> const struct iovec  *vec</td><td>ulong vlen</td><td> ulong pos_l</td><td> ulong pos_h</td><td>rwf_t flags</td></tr>
<tr><td>328</td><td>pwritev2</td><td>ulong fd</td><td> const struct iovec  *vec</td><td>ulong vlen</td><td> ulong pos_l</td><td> ulong pos_h</td><td>rwf_t flags</td></tr>
<tr bgcolor="aliceblue"><td>329</td><td>pkey_mprotect</td><td>ulong start</td><td> size_t len</td><td>ulong prot</td><td> int pkey</td></tr>
<tr><td>330</td><td>pkey_alloc</td><td>ulong flags</td><td> ulong init_val</td></tr>
<tr bgcolor="aliceblue"><td>331</td><td>pkey_free</td><td>int pkey</td></tr>
<tr><td>332</td><td>statx</td><td>int dfd</td><td> const char  *path</td><td> uflags</td><td>umask</td><td> struct statx  *buffer</td></tr>
<tr bgcolor="aliceblue"><td>333</td><td>io_pgetevents</td><td>aio_context_t ctx_id</td><td>long min_nr</td><td>long nr</td><td>struct io_event  *events</td><td>struct timespec  *timeout</td><td>const struct __aio_sigset *sig</td></tr>
<tr><td>334</td><td>rseq</td><td>struct rseq  *rseq</td><td> uint32_t rseq_len</td><td>int flags</td><td> uint32_t sig</td></tr>
<tr bgcolor="aliceblue"><td>424</td><td>pidfd_send_signal</td><td>int pidfd</td><td> int sig</td><td>siginfo_t  *info</td><td>uint flags</td></tr>
<tr><td>425</td><td>io_uring_setup</td><td>u32 entries</td><td>struct io_uring_params  *p</td></tr>
<tr bgcolor="aliceblue"><td>426</td><td>io_uring_enter</td><td>uint fd</td><td> u32 to_submit</td><td>u32 min_complete</td><td> u32 flags</td><td>const void  *argp</td><td> size_t argsz</td></tr>
<tr><td>427</td><td>io_uring_register</td><td>uint fd</td><td> uint op</td><td>void  *arg</td><td> uint nr_args</td></tr>
<tr bgcolor="aliceblue"><td>428</td><td>open_tree</td><td>int dfd</td><td> const char  *path</td><td> uflags</td></tr>
<tr><td>429</td><td>move_mount</td><td>int from_dfd</td><td> const char  *from_path</td><td>int to_dfd</td><td> const char  *to_path</td><td>uint ms_flags</td></tr>
<tr bgcolor="aliceblue"><td>430</td><td>fsopen</td><td>const char  *fs_name</td><td> uint flags</td></tr>
<tr><td>431</td><td>fsconfig</td><td>int fs_fd</td><td> uint cmd</td><td> const char  *key</td><td>const void  *value</td><td> int aux</td></tr>
<tr bgcolor="aliceblue"><td>432</td><td>fsmount</td><td>int fs_fd</td><td> uint flags</td><td> uint ms_flags</td></tr>
<tr><td>433</td><td>fspick</td><td>int dfd</td><td> const char  *path</td><td> uint flags</td></tr>
<tr bgcolor="aliceblue"><td>434</td><td>pidfd_open</td><td>pid_t pid</td><td> uint flags</td></tr>
<tr><td>435</td><td>clone3</td><td>struct clone_args  *uargs</td><td> size_t size</td></tr>
<tr bgcolor="aliceblue"><td>436</td><td>close_range</td><td>uint fd</td><td> uint max_fd</td><td>uint flags</td></tr>
<tr><td>437</td><td>openat2</td><td>int dfd</td><td> const char  *filename</td><td>struct open_how *how</td><td> size_t size</td></tr>
<tr bgcolor="aliceblue"><td>438</td><td>pidfd_getfd</td><td>int pidfd</td><td> int fd</td><td> uint flags</td></tr>
<tr><td>439</td><td>faccessat2</td><td>int dfd</td><td> const char  *filename</td><td> int mode</td><td>int flags</td></tr>
<tr bgcolor="aliceblue"><td>440</td><td>process_madvise</td><td>int pidfd</td><td> const struct iovec  *vec</td><td>size_t vlen</td><td> int behavior</td><td> uint flags</td></tr>
<tr><td>441</td><td>epoll_pwait2</td><td>int epfd</td><td> struct epoll_event  *events</td><td>int maxevents</td><td>const struct timespec  *timeout</td><td>const sigset_t  *sigmask</td><td>size_t sigsetsize</td></tr>
<tr bgcolor="aliceblue"><td>442</td><td>mount_setattr</td><td>int dfd</td><td> const char  *path</td><td>uint flags</td><td>struct mount_attr  *uattr</td><td> size_t usize</td></tr>
<tr><td>443</td><td>quotactl_fd</td><td>uint fd</td><td> uint cmd</td><td> qid_t id</td><td>void  *addr</td></tr>
<tr bgcolor="aliceblue"><td>444</td><td>landlock_create_ruleset</td><td>const struct landlock_ruleset_attr  *attr</td><td>size_t size</td><td> __u32 flags</td></tr>
<tr><td>445</td><td>landlock_add_rule</td><td>int ruleset_fd</td><td> enum landlock_rule_type rule_type</td><td>const void  *rule_attr</td><td> __u32 flags</td></tr>
<tr bgcolor="aliceblue"><td>446</td><td>landlock_restrict_self</td><td>int ruleset_fd</td><td> __u32 flags</td></tr>
<tr><td>447</td><td>memfd_secret</td><td>uint flags</td></tr>
<tr bgcolor="aliceblue"><td>448</td><td>process_mrelease</td><td>int pidfd</td><td> uint flags</td></tr>
<tr><td>449</td><td>futex_waitv</td><td>struct futex_waitv *waiters</td><td>uint nr_futexes</td><td> uint flags</td><td>struct timespec  *timeout</td><td> clockid_t clockid</td></tr>
<tr bgcolor="aliceblue"><td>450</td><td>set_mempolicy_home_node</td><td>ulong start</td><td> ulong len</td><td>ulong home_node</td><td>ulong flags</td></tr>
</table>
</body></html>







