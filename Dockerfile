FROM public.ecr.aws/lambda/nodejs:20 AS build

# Manifiesto y lock file antes que el codigo: si no cambian, esta capa
# queda cacheada y npm ci no se repite en cada build.
COPY package.json package-lock.json ./

# Instalacion reproducible desde el lock file, no resolucion nueva.
RUN npm ci

# El codigo de la app se copia despues de instalar dependencias.
COPY src ./src

# Deja el artefacto empaquetado en dist/handler.js.
RUN npm run build

# Etapa 2: final. Misma imagen base de Lambda, version fija. Recibe
# unicamente el artefacto empaquetado: no hay node_modules ni gestor de
# paquetes del sistema invocado aqui.
FROM public.ecr.aws/lambda/nodejs:20 AS final

COPY --from=build ${LAMBDA_TASK_ROOT}/dist ./dist

CMD ["dist/handler.handler"]
