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
        <div class="container mt-5">
            <div class="row justify-content-center">
                <div class="col-auto text-center">
                    
                    <%! Integer player1 = 0;%>
                    <%! Integer player2 = 0;%>
                    <%! Integer pos1;%>
                    <%! Integer pos2;%>
                    <%! Integer posant2;%>
                    <%! Integer posant1;%>
                    <%
                        Integer hitsCount = (Integer) application.getAttribute("hitCounter");
                        if (hitsCount == null || hitsCount == 0) {
                            /* First visit */
                          
                            hitsCount = 1;
                            player1 = player1 + 1;
                            player2 = player2 + 2;
                            pos1 = 0;
                            pos2 = 0;
                        } else {
                            /* return visit */
                         
                            player1 = player1 + 1;
                            player2 = player2 + 1;

                            hitsCount += 1;
                        }
                        application.setAttribute("hitCounter", hitsCount);
                    %>
                    <h2><% if(pos1>=25){
                        out.println("Player 1 won last round");
                        hitsCount = 1;
                        
                        
                        
                        }else if (pos2>=25){
                        out.println("Player 2 won last round");
                        hitsCount = 1;
                       
                        }%></h2>

                        
                    <table class="table  mx-auto ">
                        <tbody>

                            <%! public int dado() {
                                    int salida = (int) (Math.random() * 5 +1);
                                    return salida;

                                }
                            %>
                            <%!  public static int[][] matrizEspiral() {

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
                            <%! int[][] espiral = matrizEspiral();%>


                            <% if(hitsCount == 1 ){
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
                            </tr><%

                            }}else{

                                    if (player1 % 2 == 0) {
                                    pos1 = pos1 + dado();
                                    for (int i = 1; i <= 5; i++) {
%>
                            <tr>
                                <%
                                    for (int j = 1; j <= 5; j++) {
                                %>
                                <td id ="ca<%=espiral[i][j]%>"> <%
                                        if (espiral[i][j] == pos1 && espiral[i][j] == pos2) {%> <img src="ocaypato.gif"><%} 
                                        else if (espiral[i][j] == pos2) {%> <img src="Pata.gif"><%}
                                        else if (espiral[i][j] == pos1 ) {%> <img src="oca.gif"><%}%>
                                </td>
                                    <%}%>
                            </tr><%}%>
                            <%
                            } else {                                     
                                pos2 = pos2 + dado();
                                for (int i = 1; i <= 5; i++) {
%>
                            <tr>
                                <%
                                    for (int j = 1; j <= 5; j++) {
                                %>
                                <td id ="ca<%=espiral[i][j]%>"> <%
                                        if (espiral[i][j] == pos1 && espiral[i][j] == pos2) {%> <img src="ocaypato.gif"><%} 
                                        else if (espiral[i][j] == pos1) {%><img src="oca.gif"><%}
                                        else if (espiral[i][j] == pos2 ) {%> <img src="Pata.gif"%><%}%>
                                </td>
                                    <%}%>
                            </tr>
                            <%}
                                }}%> 

                        </tbody>
                    </table>
                </div>
                <div class="d-flex justify-content-between botones"><button type="button" 
                                                                            <% if(player1%2 == 0){%>
                                                                                class="btn btn-danger btn-lg" onclick="location.reload();">Player 2
                                                                                <% }else{ %>
                                                                                class="btn btn-info btn-lg" onclick="location.reload();">Player 1<%}%>
                                                                                </button>
                                                                                
                </div>
            </div>
    </body>

</html>
