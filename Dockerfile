# Dockerfile del repositorio base.
# Contiene cinco malas practicas deliberadas. Cada una lleva su numero en la
# linea anterior. Corregirlas es el bloque A1 de la guia del laboratorio.

# defecto 1
FROM public.ecr.aws/lambda/nodejs:20

# defecto 2
COPY package.json package-lock.json ./

# defecto 3
RUN npm ci

# defecto 4


# defecto 5
RUN dnf clean all

CMD ["src/handler.handler"]
