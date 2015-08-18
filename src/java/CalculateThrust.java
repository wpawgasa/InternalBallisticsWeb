/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import com.fasterxml.jackson.databind.ObjectMapper;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.ScheduledThreadPoolExecutor;
import javax.servlet.AsyncContext;
import javax.servlet.AsyncEvent;
import javax.servlet.AsyncListener;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author wpawgasa
 */
@javax.servlet.annotation.WebServlet(
    // servlet name
    name = "CalculateThrust",
    // servlet url pattern
    value = {"/CalculateThrust"},
    // async support needed
    asyncSupported = true
)
public class CalculateThrust extends HttpServlet {

    public PrintWriter out;
    public ObjectMapper mapper;
    public String testStr = "";
    public String errStr = "";

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        System.out.println("Async Servlet with thread: " + Thread.currentThread().toString());
	try { 
	    //Starting the asynchronous handling and obtaining the AsyncContext object.
	    AsyncContext ac = request.startAsync();
	 
	    //Registering a listener with the AsyncContext object to listen to events
	    //from the AsyncContext object.
	    ac.addListener(new AsyncListener() {
	      @Override
	      public void onComplete(AsyncEvent event) throws IOException {
	        System.out.println("Async complete");
	      }
	 
	      @Override
	      public void onTimeout(AsyncEvent event) throws IOException {
	        System.out.println("Timed out...");
	      }
	 
	      @Override
	      public void onError(AsyncEvent event) throws IOException {
	        System.out.println("Error...");
	      }
	 
	      @Override
	      public void onStartAsync(AsyncEvent event) throws IOException {
	        System.out.println("Starting async...");
	      }
            });

            ac.setTimeout(0);
	 
	    /**
	     * Scheduling our Long running process using an inbuilt ThreadPool. Note
	     * that we are passing the AsyncContext object to our long running process:
	     * DemoAsyncService.
	     */
	    ScheduledThreadPoolExecutor executor = new ScheduledThreadPoolExecutor(10);
	    executor.execute(new CalFunctions(ac));
	    System.out.println("Servlet completed request handling");
        } catch(Exception ex) {
            System.out.println(ex.getMessage());
        }

    }
                    

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    
}
