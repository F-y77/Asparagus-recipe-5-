name = "Asparagus is discount. Help us!"
version = "1.2"
description = "增加五种芦笋相关的新料理，试试3芦笋1冰，3芦笋1鸟蛋，4芦笋，2芦笋1冰1番茄，3芦笋1辣椒的配方吧！每种食物都有特殊效果，可在设置中调整。version:" ..version
author = "Va6gn(https://steamcommunity.com/id/sweetf77/)"
forumthread = ""

icon_atlas = "modicon.xml"
icon = "modicon.tex"

dst_compatible = true

client_only_mod = false

all_clients_require_mod = true

api_version = 10

server_filter_tags = {"Asparagus"}

priority = 3

configuration_options = {
    {
        name = "food_effects_strength",
        label = "食物效果强度",
        hover = "调整所有芦笋食物特殊效果的强度",
        options = {
            {description = "弱", data = 0.5, hover = "效果减半"},
            {description = "正常", data = 1.0, hover = "默认效果"},
            {description = "强", data = 1.5, hover = "效果增强50%"},
            {description = "超强", data = 2.0, hover = "效果翻倍"}
        },
        default = 1.0
    },
    {
        name = "tea_sanity_bonus",
        label = "芦笋芦荟舒缓茶精神值加成",
        hover = "调整芦笋芦荟舒缓茶额外恢复的精神值",
        options = {
            {description = "5", data = 5},
            {description = "10", data = 10},
            {description = "15", data = 15},
            {description = "20", data = 20}
        },
        default = 10
    },
    {
        name = "soup_temp_bonus",
        label = "芦笋热辣汤温度加成",
        hover = "调整芦笋热辣汤提供的额外体温",
        options = {
            {description = "5度", data = 5},
            {description = "10度", data = 10},
            {description = "15度", data = 15},
            {description = "20度", data = 20}
        },
        default = 10
    },
    {
        name = "family_meal_health_penalty",
        label = "芦笋全家桶健康惩罚",
        hover = "调整芦笋全家桶对健康值的惩罚",
        options = {
            {description = "无惩罚", data = 0},
            {description = "轻微 (-5)", data = -5},
            {description = "中等 (-10)", data = -10},
            {description = "严重 (-15)", data = -15}
        },
        default = -5
    },
    {
        name = "ice_cubes_healing",
        label = "芦笋番茄冰块治疗效果",
        hover = "调整芦笋番茄冰块提供的额外治疗量",
        options = {
            {description = "10", data = 10},
            {description = "15", data = 15},
            {description = "20", data = 20},
            {description = "25", data = 25}
        },
        default = 15
    },
    {
        name = "fried_eggs_efficiency_bonus",
        label = "芦笋煎蛋汤效率加成",
        hover = "调整芦笋煎蛋汤提供的工作效率加成",
        options = {
            {description = "25%", data = 1.25},
            {description = "50%", data = 1.5},
            {description = "75%", data = 1.75},
            {description = "100%", data = 2.0}
        },
        default = 1.5
    },
    {
        name = "fried_eggs_duration",
        label = "芦笋煎蛋汤效果持续时间",
        hover = "调整芦笋煎蛋汤效果的持续时间",
        options = {
            {description = "4分钟", data = 240},
            {description = "8分钟", data = 480},
            {description = "12分钟", data = 720},
            {description = "16分钟", data = 960}
        },
        default = 480
    },
    {
        name = "show_buff_messages",
        label = "显示buff提示",
        hover = "当食物效果生效时显示提示信息",
        options = {
            {description = "开启", data = true},
            {description = "关闭", data = false}
        },
        default = true
    }
}

