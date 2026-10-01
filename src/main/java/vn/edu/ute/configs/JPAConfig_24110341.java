package vn.edu.ute.configs;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

public class JPAConfig_24110341 {
    private static EntityManagerFactory factory = null;

    public static synchronized EntityManager getEntityManager() {
        if (factory == null || !factory.isOpen()) {
            try {
                factory = Persistence.createEntityManagerFactory("WebDe05_PU_24110341");
            } catch (Exception ex) {
                System.err.println(">>> [LỖI KẾT NỐI DATABASE] Không thể khởi tạo EntityManagerFactory: " + ex.getMessage());
                System.err.println(">>> Vui lòng kiểm tra MySQL Server đã bật và đúng user/password trong persistence.xml chưa.");
                throw ex;
            }
        }
        return factory.createEntityManager();
    }

    public static synchronized void close() {
        if (factory != null && factory.isOpen()) {
            factory.close();
        }
    }
}
