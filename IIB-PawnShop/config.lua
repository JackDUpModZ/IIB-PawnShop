Config = {}

Config.Stores = {
    ['Carson Avenue Pawn'] = {
        job = 'carsonpawn',
        polyData = {
            vector4(145.1233, -1783.714, 29.45838, 170.3292),
            vector4(128.7423, -1769.585, 29.45838, 142.7352),
            vector4(107.2199, -1796.35, 29.45838, 35.22498),
            vector4(121.4979, -1813.194, 29.45838, 340.7754)
        },
        pedLocation = vector4(138.6901, -1783.913, 28.7262, 53.4932),
        trayLocations = {
            vector4(133.0817, -1782.663, 29.7262, 140.9436),
            vector4(135.1201, -1784.198, 29.7262, 140.9436)
        },
        stashLocation = vector4(127.4769, -1777.656, 29.7262, 324.9603)
    },
    ['Eclipse Pawn'] = {
        job = 'eclipsepawn',
        polyData = {
            vector4(-490.4549, 274.5976, 83.24302, 354.0391),
            vector4(-487.917, 300.4026, 83.24302, 166.7263),
            vector4(-469.9781, 297.119, 83.24302, 170.8844),
            vector4(-470.6527, 274.8531, 83.24302, 352.7999)
        },
        pedLocation = vector4(-486.1155, 281.1118, 82.29394, 263.0609),
        trayLocations = {
            vector4(-483.4417, 283.3454, 83.29385, 355.0),
            vector4(-480.6996, 282.9968, 83.29385, 355.0)
        },
        stashLocation = vector4(-473.3087, 282.278, 83.29393, 182.3379)
    },
    ['Cholla Springs Pawn'] = {
        job = 'chollapawn',
        polyData = {
            vector4(1698.84, 3772.357, 34.60141, 25.27033),
            vector4(1713.097, 3781.637, 34.60141, 37.60522),
            vector4(1704.924, 3794.003, 34.60141, 120.5062),
            vector4(1691.015, 3783.894, 34.60141, 273.5098)
        },
        pedLocation = vector4(1697.601, 3780.188, 33.71101, 301.0859),
        trayLocations = {
            vector4(1698.373, 3783.851, 34.71099, 30.22067),
            vector4(1700.517, 3785.229, 34.71099, 30.22067)
        },
        stashLocation = vector4(1706.827, 3789.182, 34.71101, 213.2121)
    },
}

Config.SellItems = {
    [1] = {
        item = "rolex",
        price = math.random(30, 32)
    }
}