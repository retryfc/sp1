FROM amazonlinux
COPY program.sh program.sh
COPY sp1.sh sp1.sh
RUN chmod ugo+x program.sh
CMD ./program.sh
