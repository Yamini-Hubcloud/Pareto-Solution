# Pareto-Solution
Project Overview: Balancing Act – Optimising Production Lines with DEA and Pareto Analysis
This project explores multi-objective line-balancing (MOLB) in a simulated manufacturing environment, where economic, social, and environmental objectives must be optimized simultaneously. The MOLB game generates 26 feasible production line configurations, each representing a distinct way of allocating tasks, tools, and sustainability metrics. Traditionally, a weighted sum approach aggregates the three objectives to evaluate and rank solutions. However, this method enforces fixed preferences and may overlook other efficient alternatives.

To provide a more comprehensive and unbiased evaluation, this project applies Data Envelopment Analysis (DEA) as a comparative tool. Each line configuration is treated as a Decision-Making Unit (DMU), and an output-oriented DEA model with variable returns to scale (VRS) is used to calculate efficiency scores based on the input (e.g., number of tools, workstations) and output (objective scores) data.

The project then compares DEA results with those from the Pareto-based weighted sum approach, which uses fixed weights (50% economic, 25% social, 25% environmental) to rank the DMUs. The top five configurations with the lowest weighted sums are considered Pareto-efficient.

A side-by-side comparison highlights overlapping and differing efficient units under both methods. The results are visualized using bar plots and scatter markers, clearly distinguishing DEA-efficient and Pareto-efficient configurations.

By contrasting these two decision-support methods, the analysis emphasizes the importance of flexible evaluation frameworks in multi-objective scenarios. DEA offers a non-parametric alternative that respects the relative performance of each configuration without preset weighting bias. The project ultimately supports more informed and balanced decision-making in production line design and optimization.
