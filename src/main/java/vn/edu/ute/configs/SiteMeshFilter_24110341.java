package vn.edu.ute.configs;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpServletResponseWrapper;
import java.io.CharArrayWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@WebFilter(filterName = "SiteMeshFilter_24110341", urlPatterns = "/*")
public class SiteMeshFilter_24110341 implements Filter {

    private static final Pattern TITLE_PATTERN = Pattern.compile("<title>(.*?)</title>", Pattern.CASE_INSENSITIVE | Pattern.DOTALL);
    private static final Pattern BODY_PATTERN = Pattern.compile("<body[^>]*>(.*?)</body>", Pattern.CASE_INSENSITIVE | Pattern.DOTALL);

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {}

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        String uri = httpRequest.getRequestURI();

        String lowerUri = uri.toLowerCase();
        // Bỏ qua decorator cho tài nguyên tĩnh (hình ảnh, css, js, fonts) và request nội bộ decorator
        if (lowerUri.contains("/images/") || lowerUri.contains("/uploads/") || lowerUri.contains("/css/") || lowerUri.contains("/js/") ||
            lowerUri.endsWith(".css") || lowerUri.endsWith(".js") || lowerUri.endsWith(".png") ||
            lowerUri.endsWith(".jpg") || lowerUri.endsWith(".jpeg") || lowerUri.endsWith(".gif") ||
            lowerUri.endsWith(".ico") || lowerUri.endsWith(".webp") || lowerUri.endsWith(".svg") ||
            lowerUri.endsWith(".woff") || lowerUri.endsWith(".woff2") || lowerUri.endsWith(".ttf") ||
            httpRequest.getAttribute("DECORATOR_APPLIED") != null) {
            chain.doFilter(request, response);
            return;
        }

        CharResponseWrapper responseWrapper = new CharResponseWrapper(httpResponse);
        chain.doFilter(request, responseWrapper);

        String contentType = httpResponse.getContentType();
        if (contentType != null && !contentType.contains("text/html")) {
            response.getWriter().write(responseWrapper.toString());
            return;
        }

        String content = responseWrapper.toString();
        if (content == null || content.trim().isEmpty()) {
            return;
        }

        // Trích xuất Title và Body từ view JSP
        String title = "UTE Shop 24110341";
        Matcher titleMatcher = TITLE_PATTERN.matcher(content);
        if (titleMatcher.find()) {
            title = titleMatcher.group(1).trim();
        }

        String body = content;
        Matcher bodyMatcher = BODY_PATTERN.matcher(content);
        if (bodyMatcher.find()) {
            body = bodyMatcher.group(1).trim();
        }

        httpRequest.setAttribute("pageTitle", title);
        httpRequest.setAttribute("pageBody", body);
        httpRequest.setAttribute("DECORATOR_APPLIED", Boolean.TRUE);

        // Chọn decorator phù hợp (Admin hoặc User)
        String decoratorPath = "/WEB-INF/views/decorators/user_decorator.jsp";
        if (uri.contains("/admin/")) {
            decoratorPath = "/WEB-INF/views/decorators/admin_decorator.jsp";
        }

        httpResponse.setContentType("text/html;charset=UTF-8");
        RequestDispatcher dispatcher = httpRequest.getRequestDispatcher(decoratorPath);
        dispatcher.forward(httpRequest, httpResponse);
    }

    @Override
    public void destroy() {}

    // Lớp wrapper để hứng nội dung HTML do JSP sinh ra
    private static class CharResponseWrapper extends HttpServletResponseWrapper {
        private final CharArrayWriter charArrayWriter = new CharArrayWriter();
        private PrintWriter printWriter;

        public CharResponseWrapper(HttpServletResponse response) {
            super(response);
        }

        @Override
        public PrintWriter getWriter() {
            if (printWriter == null) {
                printWriter = new PrintWriter(charArrayWriter);
            }
            return printWriter;
        }

        @Override
        public String toString() {
            if (printWriter != null) {
                printWriter.flush();
            }
            return charArrayWriter.toString();
        }
    }
}
