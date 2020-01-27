FROM r-base
RUN apt update && apt install -y libcurl4-openssl-dev libssl-dev
ADD dep.R .
RUN Rscript dep.R
ADD app.R start.R google-auth.json script.R ./
EXPOSE 8080
CMD ["Rscript", "start.R"]