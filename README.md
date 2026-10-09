# EcoWatt — proyecto web inicial

Interfaz responsive para una plataforma de inteligencia energética para hogares peruanos. Incluye una portada inspirada en tu referencia visual (fondo verde oscuro, acentos lima, casa energética y tarjetas flotantes) y un panel modular.

## Cómo ejecutarlo en VS Code

1. Descarga y descomprime `EcoWatt-Actualizado-v4.zip`.
2. Abre VS Code → **Archivo → Abrir carpeta…** → selecciona la carpeta `EcoWatt`.
3. Instala la extensión **Live Server** (Ritwick Deyl), si no la tienes.
4. Haz clic derecho en `index.html` → **Open with Live Server**.
5. Se abrirá la web en tu navegador. También puedes abrir `index.html` directamente, aunque Live Server es preferible.

No requiere `npm install` ni compilación. Chart.js y las fuentes tipográficas se cargan desde CDN; los gráficos y fuentes externas necesitan internet.

## Qué incluye

- Portada a pantalla completa con fondo verde oscuro, fotografía de ahorro energético y presentación de los módulos.
- Tipografía ampliada, contraste más claro y paneles definidos en verde, amarillo y celeste.
- Personaje Eco animado que se desplaza por la pantalla y muestra consejos, sin voz ni síntesis de audio.
- Panel principal con consumo reciente, costo estimado, variación, metas y gráfico.
- Registro, edición y eliminación de recibos de consumo.
- Escáner de recibos: carga de una foto/imagen, lectura OCR asistida en el navegador, campos editables y confirmación antes de guardar.
- Código interno de análisis con prefijo `EW-`; no reemplaza los códigos oficiales de la empresa eléctrica.
- Informe en PDF listo para imprimir con datos del hogar, kWh, tarifa, costos, ahorro potencial, comparación, predicción básica, gráfico, aparatos y consejos.
- Sección de informe y predicción con gráfico interactivo y detalle histórico.
- Historial, gráficos de consumo y gasto, y comparación de dos periodos en kWh, soles y porcentaje.
- Metas de ahorro con indicador de avance.
- Simulador de consumo de electrodomésticos con ilustraciones, potencia, horas y costo estimado.
- Simulador solar GeoSolar, recomendaciones prácticas y asistente visual basado en reglas.
- Configuración de hogar, tarifa eléctrica y ciudad.
- Ubicación en vivo con permiso del navegador y mapa de OpenStreetMap.
- Exportación CSV, ayuda, privacidad y flujo visual de recuperación de acceso.
- Persistencia de datos de demostración en `localStorage`.

## Importante: qué es y qué no es esta versión

Esta es una **demo frontend funcional**, no un producto listo para producción. El registro/inicio de sesión es solo una simulación visual; no protege cuentas. Los datos se guardan en el navegador actual. No incluye todavía Supabase, API de IA, datos solares externos, pronóstico entrenado ni sensores ESP32. El OCR se realiza con Tesseract.js y puede equivocarse; revisa siempre los campos extraídos. Las proyecciones son cálculos aritméticos sencillos, no predicciones validadas. El mapa usa mosaicos reales de OpenStreetMap y ubicación del navegador cuando se autoriza.

Antes de publicar para usuarios reales, integra Supabase Auth y PostgreSQL, activa Row Level Security (RLS), valida los datos en servidor, usa HTTPS y protege las claves de cualquier servicio externo. No pongas claves secretas en los archivos JavaScript del navegador.

## Estructura

```text
EcoWatt/
├── index.html
├── README.md
├── assets/
│   ├── eco-lightbulb-plant.png
│   └── ecowatt-reference-dashboard.png
├── css/
│   └── styles.css
├── js/
│   └── app.js
└── sql/
    └── schema-inicial.sql
```

## Fórmulas usadas en la demo

- **Costo energético estimado:** consumo en kWh × tarifa configurada en S/kWh.
- **Variación porcentual:** (consumo nuevo − consumo anterior) / consumo anterior × 100. Si el anterior es cero, no se calcula.
- **Consumo estimado de un aparato:** potencia en W / 1000 × horas al día × días al mes.
- **Generación solar simplificada:** potencia instalada en kWp × horas solares pico al día × días × rendimiento del sistema.

El importe total del recibo puede diferir del costo energético estimado por cargos fijos, impuestos, bloques tarifarios y otros conceptos. El simulador solar es ilustrativo y no reemplaza un estudio técnico.

## Siguientes pasos recomendados

1. Conectar autenticación y base de datos reales.
2. Separar los datos por usuario/hogar mediante RLS.
3. Añadir carga privada de fotos/PDF y OCR con confirmación manual.
4. Integrar una fuente solar con cobertura comprobada para la ubicación elegida.
5. Crear un backend para IA y predicciones, mostrando fuente, supuestos y confianza.
6. Incorporar sensores/ESP32 solo después de definir un protocolo autenticado y validar las mediciones.

## Actualización visual y geolocalización

- La portada utiliza `assets/eco-lightbulb-plant.png` como fondo visual de ahorro energético.
- El personaje flotante Eco tiene animación CSS, se desplaza por la pantalla y muestra mensajes contextuales; no reproduce voz ni usa síntesis de audio.
- El módulo **Ubicación en vivo** usa la API de geolocalización del navegador y Leaflet con mosaicos de OpenStreetMap.
- Pulsa **Obtener ubicación** para una lectura puntual o **Seguimiento en vivo** para actualizar el marcador mientras el navegador reciba nuevas coordenadas. Usa **Detener** para finalizar el seguimiento.
- El navegador debe conceder permiso explícito. La geolocalización requiere un contexto seguro: HTTPS o `localhost`; por eso se recomienda ejecutar mediante Live Server.
- Si no se concede el permiso, puedes guardar manualmente la ciudad o distrito.
- La ubicación no mide el consumo eléctrico. Solo ayuda a contextualizar el análisis; los cálculos de consumo usan los recibos ingresados.
- La aplicación demo no transmite las coordenadas a un backend. La carga de mapas requiere conexión a internet y depende de los servicios de mapas externos.

### Ejecutar

1. Descomprime `EcoWatt-Actualizado-v4.zip`.
2. Abre la carpeta `EcoWatt` en Visual Studio Code.
3. Inicia `index.html` con la extensión Live Server.
4. En el panel, abre **Ubicación en vivo** y elige si quieres obtener una ubicación puntual o activar el seguimiento.


## Actualización visual v3

- Los textos principales, etiquetas, formularios, tablas y gráficos tienen mayor tamaño.
- Las tarjetas y paneles usan bordes más marcados y colores de acento verde, amarillo y celeste.
- Los gráficos incluyen tooltips interactivos, animaciones, puntos resaltados y escalas más legibles.
- La mascota Eco se desplaza por la zona inferior; si prefieres menos movimiento, el sitio respeta la opción de movimiento reducido del sistema operativo.
- El escáner usa OCR asistido desde el navegador; necesita conexión para cargar la biblioteca y los datos de idioma. La lectura puede equivocarse y requiere revisión.
- El PDF se genera localmente en el navegador y está diseñado para imprimir.
- El acceso olvidado muestra un flujo de recuperación de demostración. No envía correos ni cambia contraseñas sin un servicio de autenticación real.


## Actualización v4 — análisis por aparatos y panel ampliado

- Se añadió **Análisis por aparatos** como pantalla independiente con gráfico de barras, participación estimada de cada equipo, costos aproximados, consejos específicos y simulación de ahorro ajustable.
- El panel principal ahora incluye un gráfico de distribución por electrodoméstico y accesos visuales a escáner, historial, comparación e informe.
- Desde cada tarjeta de electrodoméstico se puede abrir el análisis detallado.
- El historial de recibos muestra también el código interno EcoWatt y el origen de cada registro.
- La navegación lateral puede desplazarse cuando la pantalla es baja, de modo que todos los módulos sigan accesibles.
- Se conservaron el escáner OCR, el informe PDF, GeoSolar, la ubicación en vivo, las metas, la comparación, la configuración y las demás funciones existentes.
