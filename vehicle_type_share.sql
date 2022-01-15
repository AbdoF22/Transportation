USE vehicles;


SELECT 
    *
FROM
    vehicles_type_share;



SELECT 
    v.Entity,
    MIN(v.Year),
    MAX(v.Year),
    ROUND(v.plugin_hybrid_share - vehicl.plugin_hybrid_share,
            2) plghyp_diff_abs,
    ROUND((v.plugin_hybrid_share - vehicl.plugin_hybrid_share) / vehicl.plugin_hybrid_share * 100) plghyp_rel,
    ROUND(v.battery_electric_share - vehic.battery_electric_share,
            2) elect_diff_abs,
    ROUND((v.battery_electric_share - vehic.battery_electric_share) / vehic.battery_electric_share * 100) elect_rel,
    ROUND(v.petrol_share - vehi.petrol_share, 2) pt_diff_abs,
	ROUND((v.petrol_share - vehi.petrol_share) / vehi.petrol_share * 100) pt_rel,
    ROUND(v.diesel_gas_share - veh.diesel_gas_share,
            2) desgas_diff_abs,
    ROUND((v.diesel_gas_share - veh.diesel_gas_share) / veh.diesel_gas_share * 100) desgas_rel,
    ROUND(v.full_mild_hybrid_share - ve.full_mild_hybrid_share,
            2) fullhyp_diff_abs,
    ROUND((v.full_mild_hybrid_share - ve.full_mild_hybrid_share) / ve.full_mild_hybrid_share * 100) fullhyp_rel
FROM
    vehicles_type_share v
        JOIN
    (SELECT 
        plugin_hybrid_share, Entity, Year
    FROM
        vehicles_type_share
    GROUP BY Entity
    HAVING Year = MIN(Year)) vehicl ON v.Entity = vehicl.Entity
        JOIN
    (SELECT 
        battery_electric_share, Entity, Year
    FROM
        vehicles_type_share
    GROUP BY Entity
    HAVING Year = MIN(Year)) vehic ON v.Entity = vehic.Entity
        JOIN
    (SELECT 
        petrol_share, Entity, Year
    FROM
        vehicles_type_share
    GROUP BY Entity
    HAVING Year = MIN(Year)) vehi ON v.Entity = vehi.Entity
        JOIN
    (SELECT 
        diesel_gas_share, Entity, Year
    FROM
        vehicles_type_share
    GROUP BY Entity
    HAVING Year = MIN(Year)) veh ON v.Entity = veh.Entity
        JOIN
    (SELECT 
        full_mild_hybrid_share, Entity, Year
    FROM
        vehicles_type_share
    GROUP BY Entity
    HAVING Year = MIN(Year)) ve ON v.Entity = ve.Entity
GROUP BY v.Entity
HAVING MAX(v.Year) >= 2017;

