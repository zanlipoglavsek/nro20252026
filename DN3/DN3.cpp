#include <iostream>
#include <cmath>

double calcAtan(double* x, int* N_steps) {
    double sum = 0;
    double x_power = *x;

    for (int i = 0; i <= *N_steps; i++) {
        double sign = (i % 2 == 0) ? 1.0 : -1.0;
        sum += sign * x_power / (2 * i + 1);

        x_power *= (*x) * (*x);
    }

    return sum;
}

int main(){
    const double PI = 3.14;
    const int del = 500;
    double h = PI / (4 * del);
    int n_steps = 500;
    double trapz_int = 0;
    for (int i = 0; i <= del;i++) {
        double x1 = h * i;
        double x2 = (i + 1) * h;
        double x1_half = x1 / 2;
        double x2_half = x2 / 2;

        trapz_int += (exp(3 * x1) * calcAtan(&x1_half, &n_steps) + exp(3 * x2) * calcAtan(&x2_half, &n_steps)) / 2 * h;
    }
    std::cout << "vrednost integrala: " << trapz_int << std::endl;

    return 0;
}
