FROM r-base
ADD dep.R .
RUN Rscript dep.R
ADD app.R start.R ./
EXPOSE 8080
CMD Rscript start.R