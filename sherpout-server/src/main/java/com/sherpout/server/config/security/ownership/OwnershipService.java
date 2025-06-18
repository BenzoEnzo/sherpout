package com.sherpout.server.config.security.ownership;

import org.springframework.stereotype.Service;

import java.util.function.Supplier;

@Service
public class OwnershipService {
    @CheckOwnership
    @SuppressWarnings("unused")
    public <T extends Ownable> void withRunnable(@CheckOwnable T entity, Runnable action) {
        action.run();
    }

    @CheckOwnership
    @SuppressWarnings("unused")
    public <T extends Ownable, R> R withSuppplier(@CheckOwnable T entity, Supplier<R> supplier) {
        return supplier.get();
    }
}
