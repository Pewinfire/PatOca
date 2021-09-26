<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU" crossorigin="anonymous">
        <link rel="stylesheet" href="css.css">
        <title>Juego de la oca</title>    
        <link rel="icon" 
              href="favicon.ico">
    </head>
    <body>

       <%-- Declaracion variables --%>
        <%! Integer player1 = 0;%>
        
        <%! Integer pos1;%>
        <%! Integer pos2;%>
        <%! Integer posant2;%>
        <%! Integer posant1;%>
        <%! Integer tirada1 = 0;%>
        <%! Integer tirada2 = 0;%>
       <%-- Funcion hitscounts para determinar turnos y otras variables --%>
        <%
            Integer hitsCount = (Integer) application.getAttribute("hitCounter");
            if (hitsCount == null || hitsCount == 0) {
                /* First visit */

                hitsCount = 1;
                player1 = player1 + 1;
              
                pos1 = 0;
                pos2 = 0;
            } else {
                /* return visit */

                player1 = player1 + 1;             
                hitsCount += 1;
            }
            application.setAttribute("hitCounter", hitsCount);
        %>
        <%-- h2 con el ganador, reinicia el juego al llegar a 25 uno de los dos --%>
        <h2><% if (pos1 >= 25) {
                out.println("Player 1 won last round");
                hitsCount = 1;

            } else if (pos2 >= 25) {
                out.println("Player 2 won last round");
                hitsCount = 1;

            }%></h2>
            <%-- funcion random para el dado --%>    
         <%!
            public int dado() {
                 int salida = (int) (Math.random() * 5 + 1);
                 return salida;

             }
         %>
            <%-- funcion para hacer la matriz espiral ( asignar ids a las celdas por unidades ascendentes en forma de espiral) --%>
        <%!
            public static int[][] matrizEspiral() {

                int n = 5;
                int x = 0;
                int[][] M = new int[n + 1][n + 1];
                for (int a = 1; a <= n / 2; a++) {
                    for (int i = a; i <= n - a; i++) {
                        M[a][i] = x;
                        x++;
                    }
                    for (int i = a; i <= n - a; i++) {
                        M[i][n - a + 1] = x;
                        x++;
                    }
                    for (int i = n - a + 1; i >= a + 1; i--) {
                        M[n - a + 1][i] = x;
                        x++;
                    }
                    for (int i = n - a + 1; i >= a + 1; i--) {
                        M[i][a] = x;
                        x++;
                    }
                }
                if (n % 2 == 1) {
                    M[n / 2 + 1][n / 2 + 1] = x;
                }
                return M;
            } %>
        <%-- matriz espiral --%>
        <%! int[][] espiral = matrizEspiral();%>
            <%-- Comienzo codigo html y jsp con la aplicacion --%>
        <div class="container mt-5">
            <div class="row justify-content-center">
                <div class="col-auto text-center">                   
                    <table class="  bg-white mx-auto ">
                        <tbody>
          <%-- Acciones dependiendo del turno (Quien tira dado). Este se obtiene a partir del hitcount (primer turno) y de la variable player1 (odd, even) --%>
                            <%-- turno 0 (ambos en casilla inicio) --%>
                            <% if (hitsCount == 1) {
                                    pos1 = 0;
                                    pos2 = 0;

                                    for (int i = 1; i <= 5; i++) {
                            %>
                            <tr>
                                    <%
                                        for (int j = 1; j <= 5; j++) {
                                    %>
                                    <td id ="ca<%=espiral[i][j]%>"> <%
                                    if (espiral[i][j] == 0) {%> <img src="ocaypato.gif"><%}%>
                                    </td>
                                <%}%>
                            </tr><%-- turno jugador 1 (contador player1 even) --%><%

                                }
                            } else {
             
                                if (player1 % 2 == 0) {
                                    tirada1 = dado();
                                    pos1 = pos1 + tirada1;
                                    for (int i = 1; i <= 5; i++) {
                            %>
                            <tr>
                                    <%
                                        for (int j = 1; j <= 5; j++) {
                                    %>
                                    <td id ="ca<%=espiral[i][j]%>"> <%
                                    if (espiral[i][j] == pos1 && espiral[i][j] == pos2) {%> <img src="ocaypato.gif"><%} else if (espiral[i][j] == pos2) {%> <img src="Pata.gif"><%} else if (espiral[i][j] == pos1) {%> <img src="oca.gif"><%}%>
                                </td>
                                <%}%>
                            </tr><%}%>
                            <%-- turno jugador 2 (contador player1 odd) --%><%
                            } else {
                                tirada2 = dado();
                                pos2 = pos2 + tirada2;
                                for (int i = 1; i <= 5; i++) {
                            %>
                            <tr>
                                    <%
                                        for (int j = 1; j <= 5; j++) {
                                    %>
                                    <td id ="ca<%=espiral[i][j]%>"> <%
                                    if (espiral[i][j] == pos1 && espiral[i][j] == pos2) {%> <img src="ocaypato.gif"><%} else if (espiral[i][j] == pos1) {%><img src="oca.gif"><%} else if (espiral[i][j] == pos2) {%> <img src="Pata.gif"%><%}%>
                                </td>
                                <%}%>
                            </tr>
                            <%}
                                    }
                                }%> 

                        </tbody>
                    </table>
                </div>
                <div class="d-flex justify-content-between botones"><button type="button" 
                                                                            <% if (player1 % 2 == 0) {%>
                                                                            class="btn btn-danger btn-lg" onclick="location.reload();">Player 2
                        <% } else { %>
                        class="btn btn-info btn-lg" onclick="location.reload();">Player 1<%}%>
                    </button>

                </div>
                <h3 class="t1">Tirada_1</h3><h3 class="dado1"><%=tirada1%></h3>
                <h3 class="t2">Tirada_2</h3><h3 class="dado2"><%=tirada2%></h3>




            </div>
    </body>

</html>
