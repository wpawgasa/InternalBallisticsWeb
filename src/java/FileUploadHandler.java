/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;
import com.fasterxml.jackson.databind.ObjectMapper;
import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.charset.Charset;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpSession;
import org.apache.tomcat.util.http.fileupload.FileItemIterator;
import org.apache.tomcat.util.http.fileupload.FileItemStream;
import org.apache.tomcat.util.http.fileupload.FileUploadException;
import org.apache.tomcat.util.http.fileupload.disk.DiskFileItemFactory;

/**
 *
 * @author wpawgasa
 */
@WebServlet(urlPatterns = {"/FileUploadHandler"})
public class FileUploadHandler extends HttpServlet {

    private boolean isMultipart;
    private String filePath = "/var/lib/tomcat7/webapps/InternalBallisticsWeb/upload/";
    //private String filePath = "/Users/wpawgasa/github/InternalBallisticsWeb/upload/";
    //private String filePath = "/Users/roongtawan/NetbeansProjects/InternalBallisticsWeb/upload/";
    private int maxFileSize = 5000 * 1024;
    private int maxMemSize = 32 * 1024;
    private File file;
    private PrintWriter out;
    private ServerMessage msg;

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
        response.setContentType("text/plain;charset=UTF-8");
        out = response.getWriter();
        msg = new ServerMessage();
        ObjectMapper mapper = new ObjectMapper();
        HttpSession session = request.getSession(false);
        String targetFolder = "Default";
        if (session.getAttribute("user") != null) {
            targetFolder = (String) session.getAttribute("user");
        }
        //filePath = filePath+targetFolder+"/";
        if (request.getParameter("action").equalsIgnoreCase("save")) {
            isMultipart = ServletFileUpload.isMultipartContent(request);
            //response.setContentType("text/plain");
            if (!isMultipart) {
                msg.setMsg_name("File Upload Result");
                msg.setMsg_status(false);
                msg.setMsg_content("No file uploaded");
                out.println(mapper.writeValueAsString(msg));
                return;
            }
            DiskFileItemFactory factory = new DiskFileItemFactory();
            // maximum size that will be stored in memory
            factory.setSizeThreshold(maxMemSize);
            // Location to save data that is larger than maxMemSize.
            factory.setRepository(new File(filePath + targetFolder + "/"));

            // Create a new file upload handler
            ServletFileUpload upload = new ServletFileUpload(factory);
            // maximum file size to be uploaded.
            upload.setSizeMax(maxFileSize);
            try {
                // Parse the request to get file items.
                FileItemIterator i = upload.getItemIterator(request);

                // Process the uploaded file items
                //Iterator i = fileItems.iterator();
                while (i.hasNext()) {
                    FileItemStream fi = i.next();

                    if (!fi.isFormField()) {
                        // Get the uploaded file parameters
                        String fieldName = fi.getFieldName();
                        String fileName = fi.getName();
                        String contentType = fi.getContentType();
                        //boolean isInMemory = fi.isInMemory();
                        //long sizeInBytes = fi.getSize();
                        // Write the file
                        if (fileName.lastIndexOf("/") >= 0) {
                            file = new File(filePath + targetFolder + "/"
                                    + fileName.substring(fileName.lastIndexOf("/")));
                        } else {
                            file = new File(filePath + targetFolder + "/"
                                    + fileName.substring(fileName.lastIndexOf("/") + 1));
                        }

                        InputStream is = new BufferedInputStream(fi.openStream());
                        ByteArrayOutputStream baos = new ByteArrayOutputStream();
                        
                        org.apache.commons.io.IOUtils.copy(is, baos);
                        byte[] bytes = baos.toByteArray();
                        if (!checkContentValidity(bytes)) {
                            throw new Exception(msg.msg_content);
                        }
                        is = new ByteArrayInputStream(bytes);
                        BufferedOutputStream output = null;
                        output = new BufferedOutputStream(new FileOutputStream(file));
                        int data = -1;
                        while ((data = is.read()) != -1) {
                            output.write(data);
                        }
                        is.close();
                        output.close();
                        msg.setMsg_name("File Upload Result");
                        msg.setMsg_status(true);
                        msg.setMsg_content("File " + fileName + " uploaded");
                        out.println(mapper.writeValueAsString(msg));

                    }
                }
            } catch (FileUploadException ex) {
                msg.setMsg_name("File Upload Result");
                msg.setMsg_status(false);
                msg.setMsg_content(ex.getMessage());
                out.println(mapper.writeValueAsString(msg));
                response.setStatus(500);
            } catch (Exception ex) {
                msg.setMsg_name("File Upload Result");
                msg.setMsg_status(false);
                msg.setMsg_content(ex.getMessage());
                out.println(mapper.writeValueAsString(msg));
                response.setStatus(500);
            } finally {
                out.close();
            }
        } else {
            File f = new File(filePath + targetFolder + "/" + request.getParameter("fileNames"));
            f.delete();
            msg.setMsg_name("File Remove Result");
            msg.setMsg_status(true);
            msg.setMsg_content("File " + filePath + targetFolder + "/" + request.getParameter("fileNames") + " removed");
            out.println(mapper.writeValueAsString(msg));
        }
    }

    private Boolean checkContentValidity(byte[] bytes) {
        InputStream is = new ByteArrayInputStream(bytes);
        String line;
        int lineCnt = 0;
        try {
            //is = fi.openStream();
            BufferedReader br = new BufferedReader(new InputStreamReader(is, Charset.forName("UTF-8")));
            while ((line = br.readLine()) != null) {
                lineCnt++;
                String[] parts = line.split(",", 6);
                if(parts.length!=3&&parts.length!=6) {
                    msg.setMsg_content("Invalid file content: Invalid number of columns");
                    return false;
                }
                
            }
            if(lineCnt<=0) {
                msg.setMsg_content("Invalid file content: No content");
                return false;
            }
            is.close();
            return true;
        } catch (IOException ex) {
            msg.setMsg_content("Invalid file content: "+ex.getMessage());
            return false;
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
