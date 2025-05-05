package com.formule1.service;

import com.formule1.dto.RegisterRequest;
import com.formule1.dto.LoginRequest;
import com.formule1.entity.Role;
import com.formule1.entity.User;
import com.formule1.repository.RoleRepository;
import com.formule1.repository.UserRepository;
import com.formule1.security.config.JwtUtils;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class AuthService {

    private final UserRepository userRepository;
    private final RoleRepository roleRepository;
    private final PasswordEncoder passwordEncoder;
    private final JwtUtils jwtUtils;

    public String register(RegisterRequest request) {
        if (userRepository.findByUsername(request.getUsername()).isPresent()) {
            throw new RuntimeException("Utilisateur existe déjà");
        }

        Role userRole = roleRepository.findByName("USER").orElseThrow(() -> new RuntimeException("Role USER non trouvé"));

        User user = new User();
        user.setUsername(request.getUsername());
        user.setPassword(passwordEncoder.encode(request.getPassword()));
        user.setRole(userRole);

        userRepository.save(user);

        return jwtUtils.generateToken(user.getUsername());
    }

    public String login(LoginRequest request) {
        User user = userRepository.findByUsername(request.getUsername())
                .orElseThrow(() -> new RuntimeException("Utilisateur introuvable"));

        if (!passwordEncoder.matches(request.getPassword(), user.getPassword())) {
            throw new RuntimeException("Mot de passe incorrect");
        }

        return jwtUtils.generateToken(user.getUsername());
    }
}
