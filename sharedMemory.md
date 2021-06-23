Print active shared memory segments.
> ipcs –m

"dest" status means memory segment is marked to be destroyed\
"nattach" field shows how many application pid's are still attached to the shared memory\

Print information about active shared memory segments.
> ipcs -q

Print information about active shared memory queues.
>ipcs -s

Print information about semaphores that is accessible semaphores.\
The ipcs –l shows limit of shared memory, semaphores and messages.
>ipcs -l

Below command shows maximum size of the single memory segment that linux process can \
allocate in its virtual address space. You can limit maximum size of the single memory \
segment by executing following command.
>cat /proc/sys/kernel/shmmax

You can set shmmax value by echoing to the concerned /proc file as below. Below command \
will set maximum size (in terms of bytes) single memory segment is set to 8388698.
>echo 8388608 > /proc/sys/kernel/shmmax

In similar fashion, you can set maximum allowable size of any single message in a System V IPC message queue, in bytes.
> echo 8192 > /proc/sys/kernel/msgmax

You can check current kernel parameter for semaphore with following command.
> cat /proc/sys/kernel/sem
